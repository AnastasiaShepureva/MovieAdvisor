//
//  MovieReviewDataModel.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

struct MovieReviewDataModel: Decodable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let overview: String?
    let vote_average: Double?
    let genres: [APIGenres]?
    let revenue: Int?
    let budget: Int?
}

struct APIGenres: Decodable {
    let id: Int?
    let name: String?
}
