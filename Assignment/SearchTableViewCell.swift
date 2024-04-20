//
//  SearchTableViewCell.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

protocol SearchTableViewCellDelegate: AnyObject {
    func didChangeCharaterInSearchField(_ text: String)
}

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var searchTF: UITextField!
    weak var delegate: SearchTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func loadView() -> SearchTableViewCell {
        return Bundle.main.loadNibNamed("SearchTableViewCell", owner: nil)?.first as! SearchTableViewCell
    }
    
    static var identifier: String {
        return "SearchTableViewCell"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    func configureUI() {
//        let imageView = UIImageView()
//        let image = UIImage.searchImage
//        imageView.image = image
//        searchTF.leftView = imageView
        searchTF.delegate = self
    }
    
}

extension SearchTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, text != " ", string != "" {
            print("aaaa",text + string)
            self.delegate?.didChangeCharaterInSearchField(text + string)
        } else {
            print("ljdfa",string)
            self.delegate?.didChangeCharaterInSearchField(string)
        }
        print("bbb",string)
        return true
    }
}
