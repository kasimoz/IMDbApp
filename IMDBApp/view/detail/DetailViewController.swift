//
//  DetailViewController.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import UIKit
import Combine
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    private var detailViewModel : DetailViewModel? = DetailViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var imdbId = ""
    var movieId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.setViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func setViewModel(){
        self.detailViewModel?.$movieDetail.sink{ movieDetail in
            DispatchQueue.main.async {
                self.title = movieDetail?.title ?? ""
                self.imdbId = movieDetail?.imdbId ?? ""
                self.lblTitle.text = movieDetail?.title ?? ""
                self.lblDescription.text = movieDetail?.description ?? ""
                self.lblDate.text = (movieDetail?.date ?? "").toDate().toString()
                self.lblVoteAverage.text = "\(movieDetail?.vote ?? 0.0)"
                let imageUrl = String(format: Constants.IMDBApp.ImageUrl, movieDetail?.imagePath ?? "")
                self.imgMovie.setImageWithUrl(imageUrl)
            }
        }.store(in: &cancellables)
        
        self.detailViewModel?.$showDialog.sink{ value in
            let _ = value ? self.startActivityIndicator() : self.stopActivityIndicator()
        }.store(in: &cancellables)
        
        self.detailViewModel?.$error.sink{ value in
            self.alertError(message: value?.localizedDescription, completion: nil)
        }.store(in: &cancellables)
        
        self.detailViewModel?.requestDetail(movieId: self.movieId ?? 0)
    }
    
    @IBAction func actionIMDBLogo(_ sender: Any) {
        self.showSafari(String(format: Constants.IMDBApp.RedirectUrl, self.imdbId ))
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
}
