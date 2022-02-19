//
//  MovieListAPIService.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

typealias MovieListAPIServiceResponse = (Result<[MovieListDataModel], Error>) -> Void

protocol MovieListAPIServiceProtocol {
    func getList(completion: @escaping MovieListAPIServiceResponse)
    func search(prefix: String, completion: @escaping MovieListAPIServiceResponse)
}

final class MovieListAPIService: MovieListAPIServiceProtocol {
    
    private let client = APIClient()
    
    func getList(completion: @escaping MovieListAPIServiceResponse) {
        let configuration = RequestConfiguration(path: "/discover/movie", queryItems: [URLQueryItem(name: "sort_by", value: "popularity.desc")])
        client.get(APIMovieListRequestResult.self, configuration: configuration) { result in
            switch result {
            case .success(let object):
                completion(.success(object.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func search(prefix: String, completion: @escaping MovieListAPIServiceResponse) {
        
        let configuration = RequestConfiguration(path: "/search/movie", queryItems: [URLQueryItem(name: "query", value: prefix)])
        
        client.get(APIMovieListRequestResult.self, configuration: configuration) { result in
            switch result {
            case .success(let object):
                completion(.success(object.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
