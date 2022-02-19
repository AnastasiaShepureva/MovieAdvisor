//
//  APIMovieListRequestResult.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

struct APIMovieListRequestResult: Decodable {
    let page: Int
    let results: [MovieListDataModel]
}
