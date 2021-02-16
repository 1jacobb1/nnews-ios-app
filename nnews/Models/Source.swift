//
//  Source.swift
//  nnews
//
//  Created by Jacob on 2/12/21.
//

import Foundation

struct Source: Codable {
    var id: String? = ""
    var name: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
