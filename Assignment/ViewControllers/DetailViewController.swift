//
//  DetailViewController.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomBtn: UIButton!
    
    var detail: NewsArticleDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUpUI() {
        self.descriptionLabel.text = detail?.description
        if let image = detail?.urlToImage, let imageURL = URL(string: image) {
            topImageView.sd_setImage(with: imageURL, placeholderImage: .placeholderImage, context: nil)
        } else if let image = detail?.backupImageUrl, let imageURL = URL(string: image) {
            topImageView.sd_setImage(with: imageURL, placeholderImage: .placeholderImage, context: nil)
        }
    }
    
    @IBAction func didTapOnBottomBtn(_ sender: Any) {
        if let url = URL(string: "https://github.com/lucyh4/NewsData") {
            UIApplication.shared.open(url)
        }
    }

}
