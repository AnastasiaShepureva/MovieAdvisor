//
//  MovieListCollectionDataSource.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import UIKit

final class MovieListCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var data: [MovieListViewModel] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieListCollectiionCell.self), for: indexPath) as? MovieListCollectiionCell
        else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        
        cell.configureCell(data[indexPath.row])
        return cell
    }
    
}
