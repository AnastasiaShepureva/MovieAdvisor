//
//  MovieReviewDataStorage.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

final class MovieReviewDataStorage {
    
    private var fetchedItems: [MovieReviewDataModel]?
    static let shared = MovieReviewDataStorage()
    private init() {}
    
    func put(_ entity: MovieReviewDataModel) {
        fetchedItems?.append(entity)
    }
    
    func getExisting(by id: Int) -> MovieReviewDataModel? {
        guard let item = fetchedItems?.filter({ $0.id == id }).first else {return nil}
        return item
    }
}
