//
//  Encodable.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw GatewayError(code: .incompatibleDictionary)
        }
        return dictionary
    }
}
