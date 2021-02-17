//
//  API+NewsService.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import Foundation
import Moya
import ReactiveSwift

extension APIEndPoint {
    static let apiThread = QueueScheduler(qos: .background, name: QueueScheduler.newsApiThreadName)
    
    static let provider: MoyaProvider<APIEndPoint> = {
        MoyaProvider<APIEndPoint>(
            endpointClosure: { target -> Endpoint in
                var targetURL = URL(target: target)
                if var urlComponents = URLComponents(url: targetURL, resolvingAgainstBaseURL: false) {
                    let additionalQueryItems: [URLQueryItem] = [
                        URLQueryItem(name: URLQueryItem.apiKeyParameter, value: Constants.API_KEY)
                    ]
                    var urlQueryItems = urlComponents.queryItems ?? []
                    urlQueryItems += additionalQueryItems
                    urlComponents.queryItems = urlQueryItems
                    targetURL = urlComponents.url!
                }
                
                return Endpoint(
                    url: targetURL.absoluteString,
                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers)
            },
            plugins: [NetworkLoggerPlugin()]
        )
    }()
    
    static func getTopHeadlines(from country: Country = .philippines,
                                category: Category? = nil,
                                searchFor keyword: String = "",
                                inPage page: Int = 1,
                                perPage limit: Int = 20) -> SignalProducer<NewsResponse, MoyaError> {
        var query: APIQuery = [
            "country": country.rawValue,
            "page": page,
            "pageSize": limit
        ]
        
        if let categoryQuery = category {
            query["category"] = categoryQuery
        }
        
        return provider.reactive
            .request(.topHeadlines(query: query))
            .observe(on: apiThread)
            .filterSuccessfulStatusCodes()
            .map(NewsResponse.self)
    }
}

extension QueueScheduler {
    static let newsApiThreadName = "NNews.API"
}

extension URLQueryItem {
    static let apiKeyParameter = "apiKey"
}
