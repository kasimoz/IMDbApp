//
//  BelongsToCollection.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import ObjectMapper

struct BelongsToCollection : Mappable {
	var id : Int?
	var name : String?
	var poster_path : String?
	var backdrop_path : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		poster_path <- map["poster_path"]
		backdrop_path <- map["backdrop_path"]
	}

}
