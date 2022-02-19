//
//  MovieReviewPresenter.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

protocol MovieReviewPresentationLogic {
    func presentResult(response: MovieReviewFlow.FetchItems.Response)
}


final class MovieReviewPresenter: MovieReviewPresentationLogic {
    
    private weak var viewController: MovieReviewDisplayLogic?
    
    func setup(viewController: MovieReviewDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentResult(response: MovieReviewFlow.FetchItems.Response) {
        var newState: MovieReviewFlow.FetchItems.ViewModel
        
        switch response.result {
            
        case .success(let data):
            newState = MovieReviewFlow.FetchItems.ViewModel(state: stateBySuccefulResult(data))
        case .failure(let error):
            newState = MovieReviewFlow.FetchItems.ViewModel(state: .failure(message: error.localizedDescription))
        }
        DispatchQueue.main.async {[weak self] in
            self?.viewController?.updateUI(viewModel: newState)
        }
    }
    
    private func stateBySuccefulResult(_ data: MovieReviewDataModel) -> MovieReviewFlow.ViewControllerState {
        
        var viewModel: MovieReviewViewModel?
        var genresStr = ""
        if let genres = data.genres?.map({ $0.name ?? "-" }) {
            genresStr = genres.joined(separator: ",")
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (data.poster_path ?? ""))
        viewModel = MovieReviewViewModel(id: data.id ?? 0, title: data.title ?? "", image: url!, overview: data.overview ?? "", rating: (data.vote_average ?? 0).description , genres: genresStr, revenue: (data.revenue ?? 0).description, budget: (data.budget ?? 0).description)

        guard let model = viewModel else { return .emptyResultReceived }
        return .dataReceived(model)
    }
}
