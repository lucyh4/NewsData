//
//  UIViewController.swift
//  Assignment
//
//  Created by Neha on 17/04/24.
//

import UIKit

extension UIViewController {
    
    static var splash: SplashViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "\(SplashViewController.self)") as? SplashViewController else { fatalError() }
        return vc
    }
    static var home: HomeViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "\(HomeViewController.self)") as? HomeViewController else { fatalError() }
        return vc
    }
    
    static var detailVC: DetailViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "\(DetailViewController.self)") as? DetailViewController else { fatalError() }
        return vc
    }
    
}

extension UIViewController {
    func moveToHome() {
        let vc = UINavigationController(rootViewController: UIViewController.home)
        set(rootViewController: vc)
    }
    internal func set(rootViewController: UIViewController) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = rootViewController
    }
}

extension UIViewController {
    func calculateMaxLines(text: String) -> Int {
            let maxSize = CGSize(width: self.view.frame.width - 15, height: CGFloat(Float.infinity))
            let charSize = UIFont.systemFont(ofSize: 16).lineHeight
            let text = (text) as NSString
            let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
            let linesRoundedUp = Int(ceil(textSize.height/charSize))
            return linesRoundedUp
    }
    
    func showToast(message : String) {
        let height = UIFont.systemFont(ofSize: 16).lineHeight * CGFloat(calculateMaxLines(text: message))
        let tempLabel = UILabel()
        tempLabel.text = message
        var width: CGFloat = 0
        if let isHidden = tabBarController?.tabBar.isHidden, isHidden {
            width = 50
        } else {
            width = 0
        }
        let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.height - width - 30, width: self.view.frame.width - 20, height: height + 30))
        toastLabel.center = self.view.center
        toastLabel.center.y = self.view.frame.height - width - 50
        
        toastLabel.backgroundColor = .systemBackground
        toastLabel.textColor = .systemBlue
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 16)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        toastLabel.addBorder(with: .systemBlue, width: 0.5)
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2, delay: 1.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {_ in
            toastLabel.removeFromSuperview()
        })
        
    }
}
