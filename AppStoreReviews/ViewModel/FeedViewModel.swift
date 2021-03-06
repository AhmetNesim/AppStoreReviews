//
//  FeedViewModel.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

public enum Rating: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case all
    
    public var title: String {
        switch self {
        case .one:      return "1⭐️"
        case .two:      return "2⭐️"
        case .three:    return "3⭐️"
        case .four:     return "4⭐️"
        case .five:     return "5⭐️"
        case .all:      return "All"
        }
    }
}

protocol FeedViewControllerDelegate: class {
    func reloadTableView()
    func routeToDetail(model: ReviewCellViewModel)
}

protocol FeedViewModelDelegate: class {
    func getReviews(completion: (() -> Void)?)
    func cellViewModel(index: Int) -> ReviewCellViewModel?
    func numberOfReviews() -> Int
    func getMostFrequentWords() -> [String]
    func filter(rating: Rating)
    func didSelect(index: Int)
}


final class FeedViewModel:FeedViewModelDelegate {
    
    weak var delegate: FeedViewControllerDelegate?
    
    private lazy var networkService = Service()
    
    private var reviews: [Review]? {
        didSet {
            guard let reviews = reviews else {return}
            filteredReviews = reviews
        }
    }
    
    func getReviews(completion: (() -> Void)?) {
        
        networkService.getReviews { [weak self] reviews in
            guard let self = self else {return}
            guard let reviews = reviews else {return}
            self.reviews = reviews.items.compactMap { Review(appStoreReview: $0) }
            self.delegate?.reloadTableView()
        }
    }
    
    func cellViewModel(index: Int) -> ReviewCellViewModel? {
        let reviewCellViewModel = ReviewCellViewModel(review: filteredReviews[index])
        return reviewCellViewModel
    }
    
    func numberOfReviews() -> Int {
        return filteredReviews.count
    }
    
    func didSelect(index: Int) {
        let model = ReviewCellViewModel(review: filteredReviews[index])
        delegate?.routeToDetail(model: model)
    }
    
    private var mostFrequentWords: [String]?
    
    public private(set) var filteredReviews = [Review] () {
        didSet {
            mostFrequentWords = findMostFrequentWords()
        }
    }
    
    func filter(rating: Rating) {
        if rating == Rating.all {
            resetFilter()
        }else {
            applyfilter(rating: rating)
        }
        delegate?.reloadTableView()
    }
    
    private func applyfilter(rating: Rating) {
        guard let items = reviews else {return}
        filteredReviews = items.filter{ $0.rating == rating.rawValue }
    }
    
    private func resetFilter() {
        guard let items = reviews else {return}
        filteredReviews = items
    }
    
    func getMostFrequentWords() -> [String] {
        return mostFrequentWords ?? []
    }
    
    private func findMostFrequentWords() -> [String] {
        // Create dictionary to map value to count
        var counts =  [String: Int] ()
        //Flattens words array
        let words = filteredReviews.flatMap({$0.content.components(separatedBy: " ").filter({$0.count > 3})})
        // Count the values with using forEach
        // Add one to its counts count if we have it, or set its count to 1 if we don't have it.
        words.forEach {counts[$0] = (counts[$0] ?? 0) + 1}
        
        return counts.sorted{ $0.value > $1.value }.map{ $0.key }.take(3)
    }
}

extension FeedViewModel {
    static func stub(reviews: [Review]) -> FeedViewModel {
        let viewModel = FeedViewModel()
        viewModel.reviews = reviews
        return viewModel
    }
}
