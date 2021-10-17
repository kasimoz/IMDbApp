//
//  Constants.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation

open class Constants: NSObject {

    public override init() {
    }
    
    public struct IMDBApp {
        public static let apiKey = "e1c92d4928c14a7540adc8a96e8296ef"
        public static let RedirectUrl = "https://www.imdb.com/title/%@"
        public static let ImageUrl = "https://image.tmdb.org/t/p/w500%@"
    }
    
    public struct Segue {
        public static let DetailViewController = "detailViewController"
    }

}
