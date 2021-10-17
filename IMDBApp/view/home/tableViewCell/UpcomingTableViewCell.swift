//
//  UpcomingTableViewCell.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMovieCell(title: String, description: String, date: String, imageUrl: String){
        self.lblMovieTitle.text = title
        self.lblMovieDescription.text = description
        self.lblMovieDate.text = date
        self.imgMovie.setImageWithUrl(imageUrl)
    }
    
    override func prepareForReuse() {
        self.imgMovie.image = nil
        self.imgMovie.sd_cancelCurrentImageLoad()
    }
    
}
