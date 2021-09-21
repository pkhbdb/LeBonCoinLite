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
        document.fetchClassifiedAds { adsFetchingResult in
            switch adsFetchingResult {
            case .success(let ads):
                XCTAssertFalse(ads.isEmpty)
            case .failure:
                XCTFail()
            }
        }
    }

    func testFetchCategories() {
        document.fetchCategories { categoriesFetchingResult in
            switch categoriesFetchingResult {
            case .success(let categories):
                XCTAssertFalse(categories.isEmpty)
            case .failure:
                XCTFail()
            }
        }
    }

}
