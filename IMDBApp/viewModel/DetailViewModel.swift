//
//  DetailViewModel.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var showDialog: Bool = false
    @Published var error: Error? = nil
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    
    func requestDetail(movieId: Int) {
        self.showDialog = true
        self.networkManager.fetchDetail(movieId: movieId, completion:{ (response, error) in
            self.showDialog = false
            if let error = error {
                self.error = error
                return
            }
            self.movieDetail = response?.toMovieDetail()
        })
    }
    
    deinit {
        print("deinit DetailViewModel")
    }
    
    
}
