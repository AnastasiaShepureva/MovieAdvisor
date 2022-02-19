//
//  MovieReviewFlow.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

enum MovieReviewFlowError: Error {
    case failure(descripton: String)
}

enum MovieReviewFlow {
    
    enum FetchItems {
        struct Request {
            let movieId: String
        }
        struct Response {
            var result: FlowRequestResult
        }
        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum FlowRequestResult {
        case success(MovieReviewDataModel)
        case failure(MovieReviewFlowError)
    }
    
    enum ViewControllerState {
        case initiated(id: Int)
        case dataReceived(MovieReviewViewModel)
        case emptyResultReceived
        case failure(message: String)
    }
}
