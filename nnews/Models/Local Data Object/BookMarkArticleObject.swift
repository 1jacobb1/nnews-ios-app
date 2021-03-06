//
//  BookMarkArticleObject.swift
//  nnews
//
//  Created by Jacob on 2/12/21.
//

import RealmSwift

class BookMarkArticleObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var sourceID: String = ""
    @objc dynamic var sourceName: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var articleDiscription: String = ""
    @objc dynamic var rawUrl: String = ""
    @objc dynamic var rawUrlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var country: String = ""
    
    override class func primaryKey() -> String? { "id" }
    
    var url: URL? {
        URL(string: rawUrl)
    }
    
    var urlToImage: URL? {
        URL(string: rawUrlToImage)
    }
}
