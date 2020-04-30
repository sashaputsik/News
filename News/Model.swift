//
//  Model.swift
//  News
//
//  Created by Sasha Putsikovich on 30.04.2020.
//  Copyright © 2020 Sasha Putsikovich. All rights reserved.
//

import Foundation

struct News: Codable{
    var status: String
    var totalResults: Int
    var articles :[Articles]
}

class Articles: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var discription: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: String?
    var content: String?
    
    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    author = try container.decodeIfPresent(String.self, forKey: .author)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    url = try container.decodeIfPresent(URL.self, forKey: .url)
    urlToImage = try container.decodeIfPresent(URL.self, forKey: .urlToImage)
    publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
    content = try container.decodeIfPresent(String.self, forKey: .content)
    }
}
struct Source: Codable {
    var id: String?
    var name: String
}
