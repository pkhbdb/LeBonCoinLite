//
//  Persister.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 23/09/2021.
//

import Foundation

class Persister {

    enum PersisterError: Error {
        case noObjectForKey(key: String)
        case decodingForKey(key: String)
    }

    enum DataType: String {
        case classifiedAd = "ads"
        case category = "categories"
    }

    func persist(ads: [ClassifiedAd]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(ads) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: DataType.classifiedAd.rawValue)
        }
    }

    func getAds() throws -> [ClassifiedAd] {
        let defaults = UserDefaults.standard
        guard let savedAds = defaults.object(forKey: DataType.classifiedAd.rawValue) as? Data else {
            throw PersisterError.noObjectForKey(key: DataType.classifiedAd.rawValue)
        }

        let decoder = JSONDecoder()
        guard let ads = try? decoder.decode([ClassifiedAd].self, from: savedAds) else {
            throw PersisterError.decodingForKey(key: DataType.classifiedAd.rawValue)
        }
        return ads
    }

    func persist(categories: [Category]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(categories) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: DataType.category.rawValue)
        }
    }

    func getCategories() throws -> [Category] {
        let defaults = UserDefaults.standard
        guard let savedCategories = defaults.object(forKey: DataType.category.rawValue) as? Data else {
            throw PersisterError.noObjectForKey(key: DataType.category.rawValue)
        }

        let decoder = JSONDecoder()
        guard let categories = try? decoder.decode([Category].self, from: savedCategories) else {
            throw PersisterError.decodingForKey(key: DataType.category.rawValue)
        }
        return categories
    }
}
