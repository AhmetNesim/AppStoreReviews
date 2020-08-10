//
//  ReviewCellViewModel.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

class ReviewCellViewModel {

    private let review: Review

    init(review: Review) {
        self.review = review
    }

    var author: String {
        return review.author
    }

    var version: String {
        return review.version
    }

    var rating: Int {
        return review.rating
    }

    var title: String {
        return review.title
    }

    var content: String {
        return review.content
    }
    
    var ratingVersionText: String {
        return review.ratingVersionText()
    }
}
