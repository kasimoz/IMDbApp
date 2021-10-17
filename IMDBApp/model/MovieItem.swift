//
//  MovieItem.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation

struct MovieItem {
    let id: Int?
    let title : String?
    var description : String?
    var date: String?
    var imagePath: String?
    
    init(id:Int?,title : String?, description : String?, date: String?, imagePath:String?) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.imagePath = imagePath
    }
}
