//
//  Model+Extensions.swift
//  MarvelApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation

extension HomeBaseResponse {
    
    func toTableMovieItemList() -> [MovieItem]? {
        return self.results?.compactMap {
            return MovieItem(id: $0.id, title: $0.title, description: $0.overview, date: $0.release_date, imagePath: $0.poster_path)
        }
    }
    
    func toCollectionMovieItemList() -> [MovieItem]? {
        return self.results?.compactMap {
            return MovieItem(id: $0.id, title: $0.title, description: $0.overview, date: $0.release_date, imagePath: $0.backdrop_path)
        }
    }
}

extension DetailBaseResponse {
    func toMovieDetail() -> MovieDetail? {
        return MovieDetail(id: self.id, imdbId: self.imdb_id, title: self.title, description: self.overview, date: self.release_date, vote: self.vote_average, imagePath: self.backdrop_path)
    }
}

