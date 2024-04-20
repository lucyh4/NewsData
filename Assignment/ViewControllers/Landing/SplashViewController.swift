//
//  ViewController.swift
//  Assignment
//
//  Created by Neha on 17/04/24.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.moveToHome()
        }
    }
    
}

