//
//  MovieReviewInterctor.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

protocol MovieReviewBusinessLogic {
    func getOverview(movieId: Int)
}

final class MovieReviewInteractor: MovieReviewBusinessLogic {
    
    private let presenter: MovieReviewPresentationLogic
    private let provider: MovieReviewDataProviderProtocol
    
    init(presenter: MovieReviewPresentationLogic, provider: MovieReviewDataProviderProtocol = MovieReviewDataProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func getOverview(movieId: Int) {
        provider.getInfo(movieId: movieId){ [weak self] requestResult in
            var result: MovieReviewFlow.FlowRequestResult
            
            switch requestResult {
            case .success(let dataModels):
                result = .success(dataModels)
            case .failure(let error):
                result = .failure(.failure(descripton: error.localizedDescription))
            }
            
            self?.presenter.presentResult(response: MovieReviewFlow.FetchItems.Response(result: result))
        }
    }
}
