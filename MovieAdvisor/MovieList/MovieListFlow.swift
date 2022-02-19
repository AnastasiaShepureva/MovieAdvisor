//
//  MovieListFlow.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import Foundation

enum MovieListFlowError: Error {
    case failure(descripton: String)
}

enum MovieListFlow {
    
    enum FetchItems {
        struct Request {}
        struct Response {
            var result: FlowRequestResult
        }
        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum FlowRequestResult {
        case success([MovieListDataModel])
        case failure(MovieListFlowError)
    }
    
    enum ViewControllerState {
        case loading
        case itemsReceived([MovieListViewModel])
        case emptyResultReceived
        case failure(message: String)
    }
}
