//
//  LeBonCoinLiteTests.swift
//  LeBonCoinLiteTests
//
//  Created by Alexandre Guzu on 19/09/2021.
//

import XCTest
@testable import LeBonCoinLite

class LeBonCoinLiteTests: XCTestCase {

    var document: Document!

    override func setUp() {
        document = Document()
    }

    override func tearDown() {}

    func testFetchAds() {
        let expectation = self.expectation(description: "Scaling")
        var ads = [ClassifiedAd]()

        document.fetchClassifiedAds { adsFetchingResult in
            switch adsFetchingResult {
            case .success(let fetchedAds):
                ads = fetchedAds
            case .failure:
                ads = []
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertFalse(ads.isEmpty)
    }

    func testFetchCategories() {
        let expectation = self.expectation(description: "Scaling")
        var categories = [Category]()

        document.fetchCategories { categoriesFetchingResult in
            switch categoriesFetchingResult {
            case .success(let fetchedCategories):
                categories = fetchedCategories
            case .failure:
                categories = []
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertFalse(categories.isEmpty)
    }

}
