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
            case .failure(let error):
                XCTFail("Error while fetching and parsing ads : \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNoThrow {
            let persistedAds = try self.document.persister.getAds()
            XCTAssertTrue(persistedAds.count == ads.count)

            if !ads.isEmpty {
                XCTAssertEqual(ads[0].id, persistedAds[0].id)
                XCTAssertEqual(ads[0].title, persistedAds[0].title)
                XCTAssertEqual(ads[0].categoryId, persistedAds[0].categoryId)
                XCTAssertEqual(ads[0].description, persistedAds[0].description)
                XCTAssertEqual(ads[0].isUrgent, persistedAds[0].isUrgent)
                XCTAssertEqual(ads[0].creationDate, persistedAds[0].creationDate)
                XCTAssertEqual(ads[0].imagesUrl.small, persistedAds[0].imagesUrl.small)
                XCTAssertEqual(ads[0].imagesUrl.thumb, persistedAds[0].imagesUrl.thumb)
            }
        }
    }

    func testFetchCategories() {
        let expectation = self.expectation(description: "Scaling")
        var categories = [Category]()

        document.fetchCategories { categoriesFetchingResult in
            switch categoriesFetchingResult {
            case .success(let fetchedCategories):
                categories = fetchedCategories
            case .failure(let error):
                XCTFail("Error while fetching and parsing categories : \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertFalse(categories.isEmpty)
        XCTAssertNoThrow {
            let persistedCategories = try self.document.persister.getCategories()
            XCTAssertTrue(persistedCategories.count == categories.count)
            if !categories.isEmpty {
                XCTAssertTrue(persistedCategories[0].id == categories[0].id)
                XCTAssertTrue(persistedCategories[0].name == categories[0].name)
            }
        }
    }

}
