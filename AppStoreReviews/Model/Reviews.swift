//
//  Reviews.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    
    let items :[Review]
    
    private enum CodingKeys: String, CodingKey {
        case feed
        case items = "entry"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let feed = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .feed)
        items = try feed.decode([Review].self, forKey: .items)
    }
}
