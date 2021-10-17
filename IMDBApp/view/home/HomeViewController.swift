//
//  HomeViewController.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var upcomingTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingPageControl: UIPageControl!
    
    private let homeViewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private let refreshControl = UIRefreshControl()
    
    private var colectionMovieList: [MovieItem]? = []
    private var tableMovieList: [MovieItem]? = []
    
    private var selectedMovieId : Int?
    private var page = 1
    private var reachedEndOfTheTable = false
    
    private let idUpcomingTableViewCell = "UpcomingTableViewCell"
    private let idNowPlayingCollectionViewCell = "NowPlayingCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.upcomingTableView.register(UINib.init(nibName: idUpcomingTableViewCell, bundle: nil), forCellReuseIdentifier: idUpcomingTableViewCell)
        self.nowPlayingCollectionView.register(UINib.init(nibName: idNowPlayingCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: idNowPlayingCollectionViewCell)
        self.upcomingTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.upcomingTableView.reloadData()
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.mainScrollView.refreshControl = refreshControl
        self.setViewModel()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.homeViewModel.requestNowPlaying()
        self.refreshControl.endRefreshing()
    }
    
    deinit {
        self.upcomingTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey] {
                    let newSize = newValue as! CGSize
                    self.upcomingTableViewHeightConstraint.constant = newSize.height
                }
            }
        }
    }
    
    
    func setViewModel(){
        self.homeViewModel.$colectionMovieList.sink{ colectionMovieList in
            DispatchQueue.main.async {
                self.colectionMovieList = colectionMovieList
                self.nowPlayingPageControl.numberOfPages = colectionMovieList?.count ?? 0
                self.nowPlayingPageControl.currentPage = 0
                self.nowPlayingCollectionView.reloadData()
            }
        }.store(in: &cancellables)
        
        self.homeViewModel.$tableMovieList.sink{ tableMovieList in
            self.reachedEndOfTheTable = false
            DispatchQueue.main.async {
                self.tableMovieList?.append(contentsOf: tableMovieList ?? [])
                self.upcomingTableView.reloadData()
            }
        }.store(in: &cancellables)
        
        self.homeViewModel.$showDialog.sink{ value in
            let _ = value ? self.startActivityIndicator() : self.stopActivityIndicator()
        }.store(in: &cancellables)
        
        self.homeViewModel.$error.sink{ value in
            self.alertError(message: value?.localizedDescription, completion: nil)
        }.store(in: &cancellables)
        
        
        self.homeViewModel.requestNowPlaying()
        self.homeViewModel.requestUpcoming(page: self.page)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            vc.movieId = self.selectedMovieId
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colectionMovieList?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idNowPlayingCollectionViewCell, for: indexPath) as? NowPlayingCollectionViewCell {
            let imageUrl = String(format: Constants.IMDBApp.ImageUrl, self.colectionMovieList?[indexPath.row].imagePath ?? "")
            cell.setNowPlayingCell(title: self.colectionMovieList?[indexPath.row].title ?? "",
                                   description: self.colectionMovieList?[indexPath.row].description ?? "",
                                   imageUrl: imageUrl)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width * 281) / 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovieId = self.colectionMovieList?[indexPath.row].id
        self.performSegue(withIdentifier:  Constants.Segue.DetailViewController, sender: nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        self.nowPlayingPageControl.currentPage = Int(pageNumber)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && !self.reachedEndOfTheTable {
            self.reachedEndOfTheTable = true
            self.page += 1
            self.homeViewModel.requestUpcoming(page : self.page)
        }
    }
    
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableMovieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idUpcomingTableViewCell, for: indexPath) as! UpcomingTableViewCell
        let imageUrl = String(format: Constants.IMDBApp.ImageUrl, self.tableMovieList?[indexPath.row].imagePath ?? "")
        cell.setMovieCell(title: self.tableMovieList?[indexPath.row].title ?? "",
                          description: self.tableMovieList?[indexPath.row].description ?? "",
                          date: (self.tableMovieList?[indexPath.row].date ?? "").toDate().toString(),
                          imageUrl: imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovieId = self.tableMovieList?[indexPath.row].id
        self.performSegue(withIdentifier: Constants.Segue.DetailViewController, sender: nil)
    }
    
    
}
