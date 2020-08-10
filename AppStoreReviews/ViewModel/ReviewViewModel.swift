//
//  ReviewViewModel.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

protocol ViewControllerDelegate: class {
    func reloadTableView()
}

class ReviewViewModel {
    
    weak var delegate: ViewControllerDelegate?
    
    private let networking = Networking()
    
    private var reviews: Reviews?
    
    public func getMostRecentReviews(language: Language,
                                     completion: (() -> Void)?) {
        
        networking.performRequest(type: Reviews.self, endpoint: AppStoreAPI.reviews(language: language)) { [weak self] response in
            guard let self = self else {return}
            switch response {
            case let .success(items):
                self.reviews = items
                guard let delegate = self.delegate else { return }
                delegate.reloadTableView()
            case let .failure(error):
                print(error)
            }
            completion?()
        }
    }
    
    public func cellViewModel(index: Int) -> ReviewCellViewModel? {
        guard let reviews = reviews else { return nil }
        let reviewCellViewModel = ReviewCellViewModel(review: reviews.items[index])
        return reviewCellViewModel
    }
    
    public var count: Int {
        return reviews?.items.count ?? 0
    }
}
