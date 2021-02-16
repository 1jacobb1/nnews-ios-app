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

//"source": {
//    "id": null,
//    "name": "Yahoo Entertainment"
//},
//"author": "Alex Smith",
//"title": "Is Bright Horizons Family Solutions (BFAM) Stock a Buy For 2021?",
//"description": "Upslope Capital recently released its Q4 2020 Investor Letter, a copy of which you can download here. The Fund returned 7.9% net of fees for the fourth...",
//"url": "https://finance.yahoo.com/news/bright-horizons-family-solutions-bfam-171438447.html",
//"urlToImage": "https://s.yimg.com/uu/api/res/1.2/Yl9MrPH5x09Kb7haajCZlg--~B/aD0yMTI7dz00MDA7YXBwaWQ9eXRhY2h5b24-/https://media.zenfs.com/en/insidermonkey.com/87fcece59eb8f4329110aa704efe23a6",
//"publishedAt": "2021-01-22T17:14:38Z",
//"content": "There were women among the crowd that marched to the Capitol and stormed the building. Shay Horse/NurPhoto via Getty ImagesThe terror inflicted on the U.S. Capitol on Jan. 6 laid bare Americas proble… [+6332 chars]"
