//
//  MovieListBuilder.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import UIKit

final class MovieListBuilder {
    
    func buildScreen() -> UIViewController {
        let presenter = MovieListPresenter()
        let interactor = MovieListInteractor(presenter: presenter)
        let viewController = MovieListViewController(interactor: interactor, state: .loading)
        presenter.setup(viewController: viewController)
        return viewController
    }
    
}
