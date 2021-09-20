//
//  Document+ClassifiedAd.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 20/09/2021.
//

import Foundation

extension Document {
    func fetchClassifiedAds(completion: @escaping ([ClassifiedAd], Error?) -> Void) throws {
        guard let url = URL(string: Configuration.AdsResourceURL) else {
            throw FetchingError.invalidURL
        }
        let task = session.dataTask(with: url) { (rawData, response, error) in
            guard error == nil else {
                completion([], FetchingError.invalidJSON)
                return
            }

            var ads: [ClassifiedAd] = []

            if let data = rawData {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                if let classifiedAds = try? decoder.decode([ClassifiedAd].self, from: data) {
                    ads.append(contentsOf: classifiedAds)
                }
                else {
                    completion([], FetchingError.parsing)
                }
            }
            completion(ads, nil)
        }
        task.resume()
    }
}
