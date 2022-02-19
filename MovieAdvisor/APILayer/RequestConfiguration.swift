//
//  RequestConfiguration.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import Foundation

struct RequestConfiguration {
    let path: String
    let queryItems: [URLQueryItem]?
    let apiKey = "enter_your_key"
    
    init(path: String, queryItems: [URLQueryItem]? = nil){
        self.path = path
        self.queryItems = queryItems
    }
}

extension RequestConfiguration {
    
    var url: URL? {
        var components = URLComponents(string: "https://api.themoviedb.org/3" + path)
        components?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let items = self.queryItems {
            items.forEach { components?.queryItems?.append($0)}
        }
        
        return components?.url
    }
    
    var headers: [String: Any] {
        return ["Content-Type": "application/json;charset=utf-8"]
    }
}
