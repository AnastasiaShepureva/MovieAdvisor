//
//  APIClient.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

class APIClient {
    
    func get<T: Decodable>(_ type: T.Type, configuration: RequestConfiguration, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = configuration.url else {
            return completion(.failure(NSError(domain: "URL not found", code: 0, userInfo: ["configurations" : configuration])))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in configuration.headers {
            request.addValue("\(value)", forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                return completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let items = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(items))
                } catch let error {
                    completion(.failure(error))
                }
            }
        })
        task.resume()
    }
}
