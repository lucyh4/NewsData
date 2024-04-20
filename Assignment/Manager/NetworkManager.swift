//
//  NetworkManager.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import Foundation
import Reachability

class NetworkManager {
    var reachability: Reachability!
    
    static let shared = NetworkManager()
    
    private init() {
        do  {
            reachability = try Reachability()
            
            NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)) , name: .reachabilityChanged, object: reachability)
            
        } catch {
            
        }
    }
    
    func startNotifier() {
        do {
            try ( NetworkManager.shared.reachability).startNotifier()
        } catch {
            print("Error ")
        }
    }
    
    @objc func networkStatusChanged(_ notfication: Notification) {
        if let reachability = notfication.object as? Reachability {
            switch reachability.connection {
            case .wifi:
                print("Reachable via wifi")
            case .cellular:
                print("Reachable via cellular")
            case .none, .unavailable:
                print("Network not raachable")
            }
        }
    }
    
    func stopNotifier() {
        NetworkManager.shared.reachability.stopNotifier()
    }
}
