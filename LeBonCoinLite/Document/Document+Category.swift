//
//  Document+Category.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 21/09/2021.
//

import Foundation

extension Document {
    func fetchCategories(completion: @escaping (Result<[Category], FetchingError>) -> Void) {
        guard let url = URL(string: Configuration.CategoriesResourceURL) else {
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
            if let categories = try? decoder.decode([Category].self, from: data) {
                completion(.success(categories))
            }
            else {
                completion(.failure(.parsing))
            }
        }
        task.resume()
    }
}
