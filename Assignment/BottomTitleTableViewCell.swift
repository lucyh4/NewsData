//
//  BottomTitleTableViewCell.swift
//  Assignment
//
//  Created by Neha on 17/04/24.
//

import UIKit

class BottomTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.roundCorners(radius: 5)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return "BottomTitleTableViewCell"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "BottomTitleTableViewCell", bundle: nil)
    }
    
    func configureUI(_ model: NewsArticleDetail) {
        titleLbl.text = model.description
//        cellImageView.image = model.image
        if let image = model.urlToImage, let imageURL = URL(string: image) {
            cellImageView.sd_setImage(with: imageURL, placeholderImage: .placeholderImage, context: nil)
        } else if let image = model.backupImageUrl, let imageURL = URL(string: image) {
            cellImageView.sd_setImage(with: imageURL, placeholderImage: .placeholderImage, context: nil)
        }
    }
    
}
