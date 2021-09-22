//
//  Document.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 19/09/2021.
//

import Foundation

class Document {
    class Configuration {
        static let AdsResourceURL: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
        static let CategoriesResourceURL: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
    }

    enum FetchingError: Error {
        case invalidURL
        case failedRequest
        case parsing
    }
}
