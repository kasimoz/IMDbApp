//
//  SpokenLanguages.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import ObjectMapper

struct SpokenLanguages : Mappable {
	var english_name : String?
	var iso_639_1 : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		english_name <- map["english_name"]
		iso_639_1 <- map["iso_639_1"]
		name <- map["name"]
	}

}
