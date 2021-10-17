//
//  BaseResponse.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation
import ObjectMapper

struct HomeBaseResponse : Mappable {
	var dates : Dates?
	var page : Int?
	var results : [Results]?
	var total_pages : Int?
	var total_results : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		dates <- map["dates"]
		page <- map["page"]
		results <- map["results"]
		total_pages <- map["total_pages"]
		total_results <- map["total_results"]
	}

}
