//
//  UIImage.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

extension UIImage {
    static var searchImage: UIImage {
        guard let img = UIImage(named: "searchImage") else { fatalError() }
        return img
    }
    static var placeholderImage: UIImage {
        guard let img = UIImage(named: "placeholderImage") else { fatalError() }
        return img
    }
    
}
