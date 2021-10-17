//
//  ProductionCountries.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import ObjectMapper

struct ProductionCountries : Mappable {
	var iso_3166_1 : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		iso_3166_1 <- map["iso_3166_1"]
		name <- map["name"]
	}

}
