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
}
