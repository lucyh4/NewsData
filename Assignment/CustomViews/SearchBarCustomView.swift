//
//  SearchBarCustomView.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import UIKit

protocol SearchBarCustomViewDelegate: AnyObject {
    func didChangeCharaterInSearchField(_ sender: String)
}

class SearchBarCustomView: UIView {
    @IBOutlet weak var searchTF: UITextField!
    weak var delegate: SearchBarCustomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func loadView() -> SearchBarCustomView {
        return Bundle.main.loadNibNamed("SearchBarCustomView", owner: nil)?.first as! SearchBarCustomView
    }
    
    func configureUI() {
        searchTF.delegate = self
    }
}

extension SearchBarCustomView: UITextFieldDelegate {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
