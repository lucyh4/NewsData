//
//  Utils.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import Foundation
import UIKit

func httpHeaders(isAuth: Bool = false, isPhotoUpload: Bool = false) -> [String: String] {
    let CONTENT_TYPE = "Content-Type"
    let ACCEPT = "Accept"
    
    return [CONTENT_TYPE: "application/x-www-form-urlencoded", ACCEPT: "*/*"]
}

func map<T: Decodable>(json: Any, to type: T.Type) throws -> T {
    let parseData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let mappedObject = try JSONDecoder().decode(T.self, from: parseData)
    return mappedObject
}
