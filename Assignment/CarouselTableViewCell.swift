//
//  CarouselTableViewCell.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

class CarouselTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var collectionCount = 2
    
    var listOfImages: [NewsArticleDetail]? {
        didSet {
            if let count = listOfImages?.count, count >= 5 {
                self.collectionCount = 5
            } else {
                self.collectionCount = listOfImages?.count ?? 0
            }
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return "CarouselTableViewCell"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CarouselTableViewCell", bundle: nil)
    }
    
    private func setUpUI() {
        pageControl.numberOfPages = collectionCount
        setUpCollectionView()
    }
    
    func setUpPageControl(model: [NewsArticleDetail]?) {
        if let count = model?.count, count >= 5 {
            pageControl.numberOfPages = 5
        } else {
            pageControl.numberOfPages = model?.count ?? 0
        }
        
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.isPagingEnabled = true
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension CarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        if let model = self.listOfImages?[indexPath.row] {
            cell.configureUI(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0 // Adjust as needed
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
}
