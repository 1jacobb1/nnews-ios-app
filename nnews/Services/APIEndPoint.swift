//
//  APIEndPoint.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import Foundation
import Alamofire
import Moya

enum APIEndPoint {
    case topHeadlines(query: APIQuery)
    case everything(query: APIQuery)
}

extension APIEndPoint {
    typealias APIQuery = [String: Any]
}

extension APIEndPoint: TargetType {
    var baseURL: URL { URL(string: "https://newsapi.org/v2")! }
    
    var path: String {
        switch self {
        //http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=API_KEY
        case .topHeadlines: return "/top-headlines"

        //http://newsapi.org/v2/everything?q=philippines&from=2021-01-22&sortBy=publishedAt&apiKey=4ec69be3e03a45a990a654b13983cf55&page=3
        case .everything: return "/everything" 
        }
    }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        .requestParameters(parameters: requestParameter,
                           encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    var requestParameter: APIQuery {
        switch self {
        case .topHeadlines(let query),
             .everything(let query):
            return query
        }
    }
}
