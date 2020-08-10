//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

struct Review: Decodable {
    let author: String
    let version: String
    let rating: Int
    let title: String
    let id: String
    let content: String
    
    func ratingVersionText() -> String {
        var stars = ""
        for _ in 0..<rating {
            stars += "⭐️"
        }
        return "\(stars) (ver: \(version))"
    }
    
    enum CodingKeys: String, CodingKey {
        case rating = "im:rating"
        case title
        case version = "im:version"
        case content
        case id
        case author
        case name
        case label
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let idDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .id)
        id = try idDict.decode(String.self, forKey: .label)
        
        let titleDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .title)
        title = try titleDict.decode(String.self, forKey: .label)

        let ratingDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .rating)
        let strRate = try ratingDict.decode(String.self, forKey: .label)
        rating = Int(strRate) ?? 0

        let versionDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .version)
        version = try versionDict.decode(String.self, forKey: .label)

        let contentDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .content)
        content = try contentDict.decode(String.self, forKey: .label)

        let authorDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .author)
        let name = try authorDict.nestedContainer(keyedBy: CodingKeys.self, forKey: .name)
        author = try name.decode(String.self, forKey: .label)
    }
    
    
}
