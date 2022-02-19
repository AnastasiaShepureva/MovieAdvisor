//
//  MovieListDataModel.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

struct MovieListDataModel: Decodable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let vote_average: Double?
}

