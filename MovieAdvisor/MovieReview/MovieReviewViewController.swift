//
//  MovieReviewViewController.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import UIKit

protocol MovieReviewDisplayLogic: AnyObject {
    func updateUI(viewModel: MovieReviewFlow.FetchItems.ViewModel)
}

class MovieReviewViewController: UIViewController {
    
    private let interactor: MovieReviewBusinessLogic
    private var state: MovieReviewFlow.ViewControllerState
    
    lazy var contentView = self.view as? MovieReviewView
    
    init(interactor: MovieReviewBusinessLogic, state: MovieReviewFlow.ViewControllerState) {
        self.interactor = interactor
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init ?(coder aDecoder: NSCoder) {
        self.interactor = MovieReviewInteractor(presenter: MovieReviewPresenter())
        self.state = .emptyResultReceived
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        let contentView = MovieReviewView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayState()
    }
    
    
    private func displayState() {
        switch state {
        case .initiated(id: let id):
            interactor.getOverview(movieId: id)
        case .dataReceived(let data):
            contentView?.updateUI(data)
        case .emptyResultReceived:
            contentView?.showEmptyView()
        case .failure(message: _):
            contentView?.showErrorView()
        }
    }
    
}

extension MovieReviewViewController: MovieReviewDisplayLogic {
    
    func updateUI(viewModel: MovieReviewFlow.FetchItems.ViewModel) {
        state = viewModel.state
        displayState()
    }
}
