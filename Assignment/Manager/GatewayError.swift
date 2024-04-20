//
//  GatewayError.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import Foundation
import UIKit

struct GatewayError: Error {
    let code: HTTPErrorCode
    var localDesccription: String {
        switch code {
        case .httpBadReques:
            return "Bade Reuest"
        case .incompatibleDictionary:
            return "Incompatible data"
        case .unknown: return "Something went wrong"
        case .user_ID_notfound:
            return "User ID not found"
        }
    }
    
}

 

struct DError: Error {
    let code: ErrorCode
    var message: String?
    var localizedDescription: String {
        
        if let api_message = message {
            return api_message
        }
        
        switch code {
        case .noInternetConnection:
            return "No Internet"
        case .pinningFail:
            return "Pinning Failed"
        case .unknown:
            return "Something went wrong"
        }
    }
}
