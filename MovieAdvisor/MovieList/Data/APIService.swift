//
//  MovieListAPIService.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

typealias APIServiceResponse = (Result<[MovieListDataModel], Error>) -> Void

protocol MovieListAPIServiceProtocol {
    func getList(completion: @escaping APIServiceResponse)
}

final class MovieListAPIService: MovieListAPIServiceProtocol {
    
    func getList(completion: @escaping APIServiceResponse) {
        completion(.success([]))
    }
}
