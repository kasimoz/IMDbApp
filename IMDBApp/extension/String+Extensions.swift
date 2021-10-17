//
//  String+Extensions.swift
//  MarvelApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation

extension String {

    func toDate(format : String = "yyyy-MM-dd") -> Date {
        guard !self.isEmpty else {
            return Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }
    
}

