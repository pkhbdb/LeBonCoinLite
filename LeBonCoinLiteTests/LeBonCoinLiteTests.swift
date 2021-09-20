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
        document.fetchClassifiedAds { ads in
            XCTAssertTrue(ads.isEmpty)
            // TODO : - doesn't test (async)
        }
    }

}
