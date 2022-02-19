//
//  MovieListInteractor.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

protocol MovieListBusinessLogic {
    func getList()
    func search(by prefix: String)
}

final class MovieListInteractor: MovieListBusinessLogic {
    
    private let presenter: MovieListPresentationLogic
    private let provider: MovieListDataProviderProtocol
    
    init(presenter: MovieListPresentationLogic, provider: MovieListDataProviderProtocol = MovieListDataProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func getList() {
        provider.getList { [weak self] requestResult in
            var result: MovieListFlow.FlowRequestResult
            
            switch requestResult {
            case .success(let dataModels):
                result = .success(dataModels)
            case .failure(let error):
                result = .failure(.failure(descripton: error.localizedDescription))
            }
            
            self?.presenter.presentResult(response: MovieListFlow.FetchItems.Response(result: result))
        }
    }
    
    func search(by prefix: String) {
        guard prefix != "" else {
            getList()
            return
        }
        
        provider.searchItem(by: prefix) { [weak self] requestResult in
            var result: MovieListFlow.FlowRequestResult
            
            switch requestResult {
            case .success(let dataModels):
                result = .success(dataModels)
            case .failure(let error):
                result = .failure(.failure(descripton: error.localizedDescription))
            }
            
            self?.presenter.presentResult(response: MovieListFlow.FetchItems.Response(result: result))
        }
    }
}
