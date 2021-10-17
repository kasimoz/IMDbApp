//
//  ProductionCompanies.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import ObjectMapper

struct ProductionCompanies : Mappable {
	var id : Int?
	var logo_path : String?
	var name : String?
	var origin_country : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		logo_path <- map["logo_path"]
		name <- map["name"]
		origin_country <- map["origin_country"]
	}

}
