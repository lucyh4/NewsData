//
//  Constants.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

struct TAG {
    static let LOADER = 11111
}

struct Constants {
    static let API_KEY = "1dd1ca0229ad4fe69b94323a6543e40c"
    
    static let baseURL = "https://newsapi.org/v2"
    
    struct BBC_NEWS {
        static let getToHeadlines = baseURL + "/top-headlines"
    }
    
}
