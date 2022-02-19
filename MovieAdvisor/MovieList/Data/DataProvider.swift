//
//  MovieListDataProvider.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

typealias DataProviderRequestResult = (Result<[MovieListDataModel], Error>) -> Void

protocol MovieListDataProviderProtocol {
    func getList(completion: @escaping DataProviderRequestResult)
}

final class MovieListDataProvider: MovieListDataProviderProtocol {
    
    private var storage: DataStorageProtocol
    private let service: APIServiceProtocol
    
    init(storage: DataStorageProtocol = DataStorage.shared, service: APIServiceProtocol = APIService()) {
        self.storage = storage
        self.service = service
    }
    
    func getList(completion: @escaping DataProviderRequestResult) {
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
}
