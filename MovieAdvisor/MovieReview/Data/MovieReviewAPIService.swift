//
//  MovieReviewAPIService.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

typealias MovieReviewAPIServiceResponse = (Result<MovieReviewDataModel, Error>) -> Void

protocol MovieReviewAPIServiceProtocol {
    func getInfo(movieId: Int, completion: @escaping MovieReviewAPIServiceResponse)
}

final class MovieReviewAPIService: MovieReviewAPIServiceProtocol {
    
    private let client = APIClient()
    
    func getInfo(movieId: Int, completion: @escaping MovieReviewAPIServiceResponse) {
        
        let configuration = RequestConfiguration(path: "/movie/\(movieId)")
        
        client.get(MovieReviewDataModel.self, configuration: configuration) { result in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
