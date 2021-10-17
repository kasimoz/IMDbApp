//
//  Genres.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import ObjectMapper

struct Genres : Mappable {
	var id : Int?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
	}

}
