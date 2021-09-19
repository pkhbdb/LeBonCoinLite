//
//  Document.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 19/09/2021.
//

import Foundation

class Document {
    private let session: URLSession

    private class Configuration {
        static let AdsResourceURL: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
    }

    init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
}
