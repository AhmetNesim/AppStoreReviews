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
    
    private var reviews: Reviews? {
        didSet {
            guard let items = reviews?.items else {return}
            filteredReviews = items
        }
    }
    
    public func getMostRecentReviews(language: Language,
                                     completion: (() -> Void)?) {
        
        networking.performRequest(type: Reviews.self, endpoint: AppStoreAPI.reviews(language: language)) { [weak self] response in
            guard let self = self else {return}
            switch response {
            case let .success(items):
                self.reviews = items
                self.delegate?.reloadTableView()
            case let .failure(error):
                print(error)
            }
            completion?()
        }
    }
    
    public func cellViewModel(index: Int) -> ReviewCellViewModel? {
        let reviewCellViewModel = ReviewCellViewModel(review: filteredReviews[index])
        return reviewCellViewModel
    }
    
    public var count: Int {
        return filteredReviews.count
    }
    
    private var filteredReviews = [Review] ()
    
    func applyFilter(rating: Int) {
        if rating == 0 {
            resetFilter()
        }else {
            filter(rating: rating)
        }
        delegate?.reloadTableView()

    }
    
    private func filter(rating: Int) {
        guard let items = reviews?.items else {return}
        filteredReviews = items.filter{ $0.rating == rating }
    }
    
    private func resetFilter() {
        guard let items = reviews?.items else {return}
        filteredReviews = items
    }
}
