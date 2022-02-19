//
//  MovieListPresenter.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

protocol MovieListPresentationLogic {
    func presentResult(response: MovieListFlow.FetchItems.Response)
}


final class MovieListPresenter: MovieListPresentationLogic {
    
    private weak var viewController: MovieListDisplayLogic?
    
    func setup(viewController: MovieListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentResult(response: MovieListFlow.FetchItems.Response) {
        var newState: MovieListFlow.FetchItems.ViewModel
        
        switch response.result {
            
        case .success(let data):
            newState = MovieListFlow.FetchItems.ViewModel(state: stateBySuccefulResult(data))
        case .failure(let error):
            newState = MovieListFlow.FetchItems.ViewModel(state: .failure(message: error.localizedDescription))
        }
        DispatchQueue.main.async {[weak self] in
            self?.viewController?.updateUI(viewModel: newState)
        }
    }
    
    private func stateBySuccefulResult(_ data: [MovieListDataModel]) -> MovieListFlow.ViewControllerState {
        
        var viewModels = [MovieListViewModel]()
        
        data.forEach { item in
            
            if let uid = item.id,
               let rating = item.vote_average,
               let title = item.title,
               let image = item.poster_path {
                let url = URL(string: "https://image.tmdb.org/t/p/w500" + image)
                
                let model = MovieListViewModel(uid: uid, imageUrl: url!, title: title, rating: rating.description)
                viewModels.append(model)
            }
        }

        return !viewModels.isEmpty ? .itemsReceived(viewModels) : .emptyResultReceived
    }
}
