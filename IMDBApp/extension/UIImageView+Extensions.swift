//
//  UIImageView+Extensions.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImageWithUrl(_ url :String){
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(systemName: "exclamationmark.triangle"), context: nil)
    }
}
