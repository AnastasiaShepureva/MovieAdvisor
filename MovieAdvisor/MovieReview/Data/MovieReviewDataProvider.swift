//
//  MovieReviewDataProvider.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

typealias MovieReviewProviderRequestResult = (Result<MovieReviewDataModel, Error>) -> Void

protocol MovieReviewDataProviderProtocol {
    func getInfo(movieId: Int, completion: @escaping MovieReviewProviderRequestResult)
}

final class MovieReviewDataProvider: MovieReviewDataProviderProtocol {
    
    private let storage = MovieReviewDataStorage.shared
    private let service: MovieReviewAPIServiceProtocol
    
    init(service: MovieReviewAPIServiceProtocol = MovieReviewAPIService()) {
        self.service = service
    }
    
    func getInfo(movieId: Int, completion: @escaping MovieReviewProviderRequestResult) {
        if let overview = storage.getExisting(by: movieId) {
            return completion(.success(overview))
        }
        
        service.getInfo(movieId: movieId) {[weak self] result in
            switch result {
            case .success(let info):
                self?.storage.put(info)
                return completion(.success(info))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
