//
//  Document+Category.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 21/09/2021.
//

import Foundation

extension Document {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let url = URL(string: Configuration.CategoriesResourceURL) else {
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
            do {
                let categories = try decoder.decode([Category].self, from: data)
                self.persister.persist(categories: categories)
                completion(.success(categories))
            } catch(let error) {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
