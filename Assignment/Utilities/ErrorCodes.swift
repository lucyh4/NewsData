//
//  ErrorCodes.swift
//  Assignment
//
//  Created by Neha on 17/04/24.
//

import Foundation

enum HTTPErrorCode: String {
    //MARK: - HTTP error codes
    case httpBadReques = "404"
    case incompatibleDictionary = "4000"
    case unknown
    case user_ID_notfound
}


enum ErrorCode: String {
    case noInternetConnection = "001"
    case pinningFail = "005"
    case unknown
}


