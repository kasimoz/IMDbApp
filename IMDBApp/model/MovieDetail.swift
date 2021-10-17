//
//  MovieDetail.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation

struct MovieDetail {
    let id: Int?
    let imdbId: String?
    let title : String?
    var description : String?
    var date: String?
    var vote: Double?
    var imagePath: String?
    
    init(id:Int?, imdbId : String?,title : String?, description : String?, date: String?, vote:Double?, imagePath:String?) {
        self.id = id
        self.imdbId = imdbId
        self.title = title
        self.description = description
        self.date = date
        self.vote = vote
        self.imagePath = imagePath
    }
}
