//
//  FeedViewModelTest.swift
//  AppStoreReviewsTests
//
//  Created by AHMET OMER NESIM on 11.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import XCTest
@testable import AppStoreReviews

class FeedViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test_whenUpdatingReviews_thenViewModelReturnCorrectCellItem() {

        //given
        let mockReviews: [Review] =
        [Review.stub(author: "Author1", version: "1.1", rating: 1, title: "title1", id: "1", content: "Review one content"),
        Review.stub(author: "Author2", version: "1.2", rating: 2, title: "title2", id: "2", content: "Review two content"),
        Review.stub(author: "Author3", version: "1.3", rating: 3, title: "title3", id: "3", content: "Review three content"),
        Review.stub(author: "Author4", version: "1.4", rating: 4, title: "title4", id: "4", content: "Review four content"),
        Review.stub(author: "Author5", version: "1.5", rating: 5, title: "title5", id: "5", content: "Review five content"),
        Review.stub(author: "Author6", version: "1.6", rating: 2, title: "title6", id: "6", content: "Review six content")]
        
        let viewModel = FeedViewModel.stub(reviews: mockReviews)

        // when
        let cell0 = viewModel.cellViewModel(index: 0)
        let cell1 = viewModel.cellViewModel(index: 1)
        let cell2 = viewModel.cellViewModel(index: 2)
        let cell3 = viewModel.cellViewModel(index: 3)
        
        //Then
        XCTAssertEqual(cell0?.rating, 1)
        XCTAssertEqual(cell1?.title, "title2")
        XCTAssertEqual(cell2?.version, "1.3")
        XCTAssertEqual(cell3?.content, "Review four content")
    }
    
    func test_whenTwoElementArrayGiven_thenNumberOfReviewsShouldReturnTwo() {
        
        //given
        let mockReviews: [Review] =
        [Review.stub(author: "Author1", version: "1.1", rating: 1, title: "title1", id: "1", content: "Review one content"),
        Review.stub(author: "Author2", version: "1.2", rating: 2, title: "title2", id: "2", content: "Review two content")]
        
        let viewModel = FeedViewModel.stub(reviews: mockReviews)
        
        //when
        let count = viewModel.numberOfReviews()
        
        //then
        XCTAssertEqual(count, 2)
    }
    
    func test_whenGetTheMostFrequentWord_thenGetMostFrequentFunctionShouldReturnThreeSizeList() {
        //given
        let mockReviews: [Review] =
        [Review.stub(author: "Author1", version: "1.1", rating: 1, title: "title1", id: "1", content: "Review one content"),
        Review.stub(author: "Author2", version: "1.2", rating: 2, title: "title2", id: "2", content: "Review two content"),
        Review.stub(author: "Author3", version: "1.3", rating: 3, title: "title3", id: "3", content: "Review three")]
        
        let viewModel = FeedViewModel.stub(reviews: mockReviews)
        
        //when
        let count = viewModel.getMostFrequentWords().count
        
        //then
        XCTAssertEqual(count, 3)
    }
    
    func test_whenAhmetIsTheMostFrequentWord_thenGetMostFrequentFunctionShouldReturnAhmetAsFirstElement() {
        //given
        let mockReviews: [Review] =
        [Review.stub(author: "Author1", version: "1.1", rating: 1, title: "title1", id: "1", content: "Ahmet Omer Nesim"),
        Review.stub(author: "Author2", version: "1.2", rating: 2, title: "title2", id: "2", content: "Ahmet Nesim"),
        Review.stub(author: "Author3", version: "1.3", rating: 3, title: "title3", id: "3", content: "Ahmet Omer")]

        let viewModel = FeedViewModel.stub(reviews: mockReviews)

        //when
        let mostFrequentWord = viewModel.getMostFrequentWords()[0]

        //then
        XCTAssertEqual(mostFrequentWord, "Ahmet")
    }
    
    func test_whenTheMostFrequentWordLessThan4Characters_thenGetMostFrequentFunctionShouldNotReturnThatWord() {
        //given
        let mockReviews: [Review] =
        [Review.stub(author: "Author1", version: "1.1", rating: 1, title: "title1", id: "1", content: "abc Omer Nesim"),
        Review.stub(author: "Author2", version: "1.2", rating: 2, title: "title2", id: "2", content: "abc Nesim"),
        Review.stub(author: "Author3", version: "1.3", rating: 3, title: "title3", id: "3", content: "abc Omer"),
        Review.stub(author: "Author4", version: "1.4", rating: 4, title: "title4", id: "4", content: "abc Omer asdf")]

        let viewModel = FeedViewModel.stub(reviews: mockReviews)

        //when
        let mostFrequentWord = viewModel.getMostFrequentWords()[0]

        //then
        XCTAssertFalse(mostFrequentWord == "abc")
    }

    func test_whenMockReviewsGiven_thenShouldFilterCorrectly() {
        
        //given
        let mockReviews: [Review] =
        [Review.stub(author: "Author1", version: "1.1", rating: 1, title: "title1", id: "1", content: "Review one content"),
        Review.stub(author: "Author2", version: "1.2", rating: 1, title: "title2", id: "2", content: "Review two content"),
        Review.stub(author: "Author3", version: "1.3", rating: 3, title: "title3", id: "3", content: "Review three content"),
        Review.stub(author: "Author4", version: "1.4", rating: 4, title: "title4", id: "4", content: "Review four content")]
        
        let viewModel = FeedViewModel.stub(reviews: mockReviews)
        
        //when
        viewModel.filter(rating: Rating(rawValue: 1)!)
        
        //Then
        XCTAssert(viewModel.filteredReviews.count == 2)
        
        viewModel.filteredReviews.forEach{
            XCTAssert($0.rating == 1)
        }
    }


}
