//
//  ClassifiedAd.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 20/09/2021.
//

import Foundation

struct ClassifiedAd: Codable {
    struct ImagesURL: Codable {
        var small: String?
        var thumb: String?
    }
    
    var id: Int
    var title: String
    var categoryId: Int
    var creationDate: Date
    var description: String
    var isUrgent: Bool
    var price: Double

    var imagesUrl: ImagesURL
}
