//
//  NewsResponse.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import Foundation

struct NewsResponse: Codable {
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article] = []
    
    enum CodingKeys: String, CodingKey {
        case status,
             totalResults,
             articles
    }
}
