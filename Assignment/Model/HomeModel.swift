//
//  HomeModel.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

struct DetailModel {
    var description: String?
    var image: UIImage?
}

struct NewsRequestBody: Codable {
    var sources: String
    var apiKey: String
}

struct NewsResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [NewsArticleDetail]?
}

struct NewsArticleDetail: Codable {
    var source: NewsSourceDetail?
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    var backupImageUrl: String?
    var backUpDescrition: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, description, urlToImage
        case backupImageUrl = "url"
        case backUpDescrition = "content"
    }
    
}

struct NewsSourceDetail: Codable {
    var id: String?
    var name: String?
}


struct DataBaseDetail: Codable {
    var imageURL: String
    var desc: String
}
