//
//  Review+Stub.swift
//  AppStoreReviewsTests
//
//  Created by AHMET OMER NESIM on 11.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation
@testable import AppStoreReviews

extension Review {
    
    static func stub(author:String = "author", version:String = "version", rating:Int = 1, title:String = "title", id:String = "1", content:String = "content") -> Self {
        Review(author: author, version: version, rating: rating, title: title, id: id, content: content);
    }
    
}
