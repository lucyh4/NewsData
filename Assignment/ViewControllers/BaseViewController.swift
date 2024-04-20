//
//  BaseViewController.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import UIKit

/** Class to handle all the common funtionality for all the viewControllers
 1. Controllers can inherit this Class to use the common functions
 2. We can maintain common navigation bar from here - let say If we want to add a common Notification icon (programmatically) on all the controllers then we just need to add that in this controller and on everycontroller it will be implemented
 **/
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(internetAvailabe(_:)), name: Notification.Name.internetAvailable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(internetNotAvailable(_:)), name: Notification.Name.internetNotAvailable, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.internetAvailable, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.internetNotAvailable, object: nil)
    }
    
    @objc func internetAvailabe(_ notification: NotificationCenter) {
        self.showToast(message: "Internet is available now..")
    }
    
    @objc func internetNotAvailable(_ notification: NotificationCenter) {
        self.showToast(message: "No Internet Connectivity..")
    }
    
    func isInternetConnected() -> Bool {
        if NetworkManager.shared.reachability.connection != .unavailable {
            return true
        } else {
            return false
        }
    }
}
