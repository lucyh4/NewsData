//
//  CommonLoader.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

protocol CommontLoader where Self: UIViewController {
    var indicator: UIActivityIndicatorView! { get set }
    func showLoading()
    func hideLoading()
}
extension CommontLoader {
    func showLoading() {
        DispatchQueue.main.async {
            let view = UIView(frame: self.view.frame)
            view.backgroundColor = .black.withAlphaComponent(0.3)
            view.tag = TAG.LOADER
            self.view.addSubview(view)
            self.indicator.isHidden = false
            self.indicator.startAnimating()
        }
    }
    func hideLoading() {
        DispatchQueue.main.async {
            self.indicator.color = .white
            let view = self.view.viewWithTag(TAG.LOADER)
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            view?.removeFromSuperview()
        }
    }
}
