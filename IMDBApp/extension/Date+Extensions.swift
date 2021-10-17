//
//  Date+Extensions.swift
//  MarvelApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation

extension Date {
    
    func toString(format : String = "dd.MM.yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
