//
//  MovieListView.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import UIKit

class MovieListView: UIView {
    
    weak var delegate: MovieListViewControllerDelegate?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.keyboardType = .asciiCapable
        searchBar.returnKeyType = .search
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelection = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieListCollectiionCell.self, forCellWithReuseIdentifier: String(describing: MovieListCollectiionCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.95, height: 70)
        layout.minimumInteritemSpacing = 3
        return layout
    }()
    
    private lazy var errorView: CommonView = {
        let view = CommonView(presentation: .error)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyResultView: CommonView = {
        let view = CommonView(presentation: .emptyResult)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init ?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        
        addSubview(searchBar)
        setupConstraintsForSearchBar()
        
        addSubview(movieCollectionView)
        setupConstraintsForCollectionView()
        
        addSubview(emptyResultView)
        setupConstraintsForCommonView(emptyResultView)
        
        addSubview(errorView)
        setupConstraintsForCommonView(errorView)
    }
    
    private func setupConstraintsForSearchBar() {
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupConstraintsForCollectionView() {
        
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            movieCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8)
        ])
    }
    
    private func setupConstraintsForCommonView(_ view: CommonView) {
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        
        movieCollectionView.delegate = delegate
        movieCollectionView.dataSource = dataSource
        movieCollectionView.reloadData()
    }
    
    func showEmptyView() {
        searchBar.isHidden = true
        emptyResultView.isHidden = false
    }
    
    func showErrorView() {
        searchBar.isHidden = true
        errorView.isHidden = false
    }
    
    func hideCommonViews() {
        guard searchBar.isHidden else {return}
        searchBar.isHidden = false
        emptyResultView.isHidden = true
        errorView.isHidden = true
    }
}

extension MovieListView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchMovie(prefix: searchText)
    }
}
