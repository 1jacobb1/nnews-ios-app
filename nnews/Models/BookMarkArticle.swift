//
//  BookMarkArticle.swift
//  nnews
//
//  Created by Jacob on 2/12/21.
//

import Foundation

struct BookMarkArticle {
    var id: String = ""
    var source: Source? = Source()
    var author: String? = ""
    var title: String? = ""
    var description: String? = ""
    var url: URL? = nil
    var urlToImage: URL? = nil
    var publishedAt: String = ""
    var content: String? = ""
    var category: Category? = nil
    var country: Country? = .philippines
    
    var rawUrl: String {
        url?.absoluteString ?? ""
    }
    
    var rawUrlToImage: String {
        urlToImage?.absoluteString ?? ""
    }
}

extension BookMarkArticle: Persistable {
    init(realmObject obj: BookMarkArticleObject) {
        id = obj.id
        source = Source(id: obj.sourceID,
                        name: obj.sourceName)
        author = obj.author
        title = obj.title
        description = obj.articleDiscription
        url = obj.url
        urlToImage = obj.urlToImage
        publishedAt = obj.publishedAt
        content = obj.content
        country = Country(rawValue: obj.country)
        category = Category(rawValue: obj.category)
    }
    
    init(article: Article) {
        id = article.id
        source = article.source
        author = article.author
        title = article.title
        description = article.description
        url = article.url
        urlToImage = article.urlToImage
        publishedAt = article.publishedAt
        content = article.content
        country = article.country
        category = article.category
    }
    
    func managedObject() -> BookMarkArticleObject {
        let obj = BookMarkArticleObject()
        obj.id = id
        obj.sourceID = source?.id ?? ""
        obj.sourceName = source?.name ?? ""
        obj.author = author ?? ""
        obj.title = title ?? ""
        obj.articleDiscription = description ?? ""
        obj.rawUrl = rawUrl
        obj.rawUrlToImage = rawUrlToImage
        obj.publishedAt = publishedAt
        obj.content = content ?? ""
        obj.country = country?.rawValue ?? ""
        obj.category = category?.rawValue ?? ""
        return obj
    }
}
