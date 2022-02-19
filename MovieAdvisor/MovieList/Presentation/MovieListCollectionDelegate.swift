//
//  MovieListCollectionDelegate.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import UIKit

class MovieListCollectionDelegate: NSObject, UICollectionViewDelegate {
    
    var data: [MovieListViewModel] = []
    weak var delegate: MovieListViewControllerDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        delegate?.openMovieReview(item.uid)
    }
}
