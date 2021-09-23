//
//  Document+ClassifiedAd.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 20/09/2021.
//

import Foundation

extension Document {
    func fetchClassifiedAds(completion: @escaping (Result<[ClassifiedAd], FetchingError>) -> Void) {
        guard let url = URL(string: Configuration.AdsResourceURL) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (rawData, response, error) in
            guard error == nil, let data = rawData else {
                completion(.failure(.failedRequest))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            if let classifiedAds = try? decoder.decode([ClassifiedAd].self, from: data) {
                self.persister.persist(ads: classifiedAds)
                completion(.success(classifiedAds))
            }
            else {
                completion(.failure(.parsing))
            }
        }
        task.resume()
    }
}
