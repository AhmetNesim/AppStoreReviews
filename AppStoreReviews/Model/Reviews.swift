//
//  Reviews.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    
    let items :[AppStoreReview]
    
    private enum CodingKeys: String, CodingKey {
        case feed
        case items = "entry"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let feed = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .feed)
        items = try feed.decode([AppStoreReview].self, forKey: .items)
    }
}


public struct AppStoreReview: Decodable {
    
    public let author: String
    public let id: String
    public let version: String
    public let rating: Int
    public let title: String
    public let content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case rating = "im:rating"
        case title
        case version = "im:version"
        case content
        case author
        case name
        case label
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
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
        
        let idDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .id)
        id = try idDict.decode(String.self, forKey: .label)
    }
}
