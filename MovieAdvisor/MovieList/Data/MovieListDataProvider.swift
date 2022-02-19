//
//  MovieListDataProvider.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

typealias MovieListProviderRequestResult = (Result<[MovieListDataModel], Error>) -> Void

protocol MovieListDataProviderProtocol {
    func getList(completion: @escaping MovieListProviderRequestResult)
    func searchItem(by prefix: String, completion: @escaping MovieListProviderRequestResult)
}

final class MovieListDataProvider: MovieListDataProviderProtocol {
    
    private let storage = MovieListDataStorage.shared
    private let service: MovieListAPIServiceProtocol
    
    init(service: MovieListAPIServiceProtocol = MovieListAPIService()) {
        self.service = service
    }
    
    func getList(completion: @escaping MovieListProviderRequestResult) {
        if let list = storage.fetchedItems, !list.isEmpty {
            return completion(.success(list))
        }
        
        service.getList {[weak self] result in
            switch result {
            case .success(let list):
                self?.storage.fetchedItems = list
                return completion(.success(list))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func searchItem(by prefix: String, completion: @escaping MovieListProviderRequestResult) {
        if let list = storage.fetchedItems?.filter({ ($0.title ?? "").contains(prefix) }), !list.isEmpty {
            return completion(.success(list))
        }
        
        service.search(prefix: prefix) {[weak self] result in
            switch result {
            case .success(let list):
                self?.storage.addItems(list)
                return completion(.success(list))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
