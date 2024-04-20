//
//  ImageCollectionViewCell.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var courselImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        courselImageView.roundCorners(radius: 10)
        // Initialization code
    }
    
    static var identifier: String {
        return "ImageCollectionViewCell"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
    func configureUI(model: NewsArticleDetail) {
        if let image = model.urlToImage, let imageURL = URL(string: image) {
            courselImageView.sd_setImage(with: imageURL, placeholderImage: .placeholderImage, context: nil)
        } else if let image = model.backupImageUrl, let imageURL = URL(string: image) {
            courselImageView.sd_setImage(with: imageURL, placeholderImage: .placeholderImage, context: nil)
        }
      
    }

}
