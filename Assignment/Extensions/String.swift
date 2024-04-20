//
//  String.swift
//  Assignment
//
//  Created by Neha on 19/04/24.
//

import UIKit

extension String {
    func isBackSpace() -> Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        return false
    }
}
