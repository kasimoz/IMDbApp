//
//  NowPlayingCollectionViewCell.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgNowPlay: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setNowPlayingCell(title: String, description: String, imageUrl: String){
        self.lblMovieTitle.text = title
        self.lblMovieDescription.text = description
        self.imgNowPlay.setImageWithUrl(imageUrl)
    }
    
    override func prepareForReuse() {
        self.imgNowPlay.image = nil
        self.imgNowPlay.sd_cancelCurrentImageLoad()
    }

}
