//
//  MovieReviewBuilder.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import UIKit

final class MovieReviewBuilder {
    
    func buildScreen(movieId: Int) -> UIViewController {
        let presenter = MovieReviewPresenter()
        let interactor = MovieReviewInteractor(presenter: presenter)
        let viewController = MovieReviewViewController(interactor: interactor, state: .initiated(id: movieId))
        presenter.setup(viewController: viewController)
        return viewController
    }
    
}
