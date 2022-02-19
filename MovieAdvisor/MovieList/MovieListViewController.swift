//
//  MovieListViewController.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import UIKit

protocol MovieListDisplayLogic: AnyObject {
    func updateUI(viewModel: MovieListFlow.FetchItems.ViewModel)
}

protocol MovieListViewControllerDelegate: AnyObject {
    func openMovieReview(_ id: Int)
    func searchMovie(prefix: String)
}

class MovieListViewController: UIViewController {
    
    private let interactor: MovieListBusinessLogic
    private var state: MovieListFlow.ViewControllerState
    
    private let collectionDataSource = MovieListCollectionDataSource()
    private let collectionViewDelegate = MovieListCollectionDelegate()
    
    private lazy var contentView = self.view as? MovieListView
    
    init(interactor: MovieListBusinessLogic, state: MovieListFlow.ViewControllerState) {
        self.interactor = interactor
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init ?(coder aDecoder: NSCoder) {
        self.interactor = MovieListInteractor(presenter: MovieListPresenter())
        self.state = .loading
       super.init(coder: aDecoder)
    }
    
    override func loadView() {
        let contentView = MovieListView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDelegate.delegate = self
        contentView?.delegate = self
        displayState()
    }
    
    
    private func displayState() {
        switch state {
            
        case .loading:
            interactor.getList()
        case .itemsReceived(let data):
            contentView?.hideCommonViews()
            collectionDataSource.data = data
            collectionViewDelegate.data = data
            contentView?.updateCollectionView(delegate: collectionViewDelegate, dataSource: collectionDataSource)
        case .emptyResultReceived:
            collectionDataSource.data = []
            collectionViewDelegate.data = []
            contentView?.updateCollectionView(delegate: collectionViewDelegate, dataSource: collectionDataSource)
            contentView?.showEmptyView()
        case .failure(message: _):
            contentView?.showErrorView()
        }
    }
    
}


extension MovieListViewController: MovieListDisplayLogic {
    func updateUI(viewModel: MovieListFlow.FetchItems.ViewModel) {
        state = viewModel.state
        displayState()
    }
}

extension MovieListViewController: MovieListViewControllerDelegate {
    func openMovieReview(_ id: Int) {
        let movieReviewController = MovieReviewBuilder().buildScreen(movieId: id)
        navigationController?.pushViewController(movieReviewController, animated: true)
    }
    
    func searchMovie(prefix: String) {
        interactor.search(by: prefix)
    }
}
