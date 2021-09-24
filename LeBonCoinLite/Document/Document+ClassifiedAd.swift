//
//  Document+ClassifiedAd.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 20/09/2021.
//

import Foundation

extension Document {
    func fetchClassifiedAds(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        guard let url = URL(string: Configuration.AdsResourceURL) else {
            completion(.failure(FetchingError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (rawData, response, error) in
            guard error == nil, let data = rawData else {
                completion(.failure(FetchingError.failedRequest))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            do {
                let classifiedAds = try decoder.decode([ClassifiedAd].self, from: data)
                self.persister.persist(ads: classifiedAds)
                completion(.success(classifiedAds))
            } catch(let error) {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
