//
//  HomeViewModel.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var colectionMovieList: [MovieItem]? = []
    @Published var tableMovieList: [MovieItem]? = []
    @Published var showDialog: Bool = false
    @Published var error: Error? = nil
    
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    
    func requestNowPlaying() {
        self.showDialog = true
        self.networkManager.fetchNowPlaying(completion:{ (response, error) in
            self.showDialog = false
            if let error = error {
                self.error = error
                return
            }
            self.colectionMovieList = response?.toCollectionMovieItemList()
        })
    }
    
    func requestUpcoming(page : Int) {
        self.showDialog = page == 1
        self.networkManager.fetchUpcoming(page: page, completion:{ (response, error) in
            self.showDialog = false
            if let error = error {
                self.error = error
                return
            }
            self.tableMovieList = response?.toTableMovieItemList()
        })
    }

}
