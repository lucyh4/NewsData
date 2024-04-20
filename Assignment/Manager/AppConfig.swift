//
//  AppConfig.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import Foundation

struct AppConfig {
    static func setUp() {
        NetworkManager.shared.startNotifier()
    }
}
