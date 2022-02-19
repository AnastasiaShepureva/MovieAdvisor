//
//  MovieListDataStorage.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

final class MovieListDataStorage {
    
    static let shared = MovieListDataStorage()
    var fetchedItems: [MovieListDataModel]?
    
    private init() {}
    
    func addItems(_ list: [MovieListDataModel]) {
        guard var items = fetchedItems else {
            fetchedItems = list.sorted(by: { ($0.vote_average ?? 0) > ($1.vote_average ?? 0) })
            return
        }
        
        list.forEach({ newMovie in
            if !items.contains(where: { $0.id == newMovie.id }) {
                items.append(newMovie)
            }
        })
        
        items.sort(by: { ($0.vote_average ?? 0) > ($1.vote_average ?? 0) })
        fetchedItems = items
    }
}
