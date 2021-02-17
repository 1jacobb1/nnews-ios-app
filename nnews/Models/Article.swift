//
//  Article.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import Foundation
import Fakery

struct Article: Codable {
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
    var isBookMarked: Bool = false
    
    var rawUrl: String {
        url?.absoluteString ?? ""
    }
    
    var rawUrlToImage: String {
        urlToImage?.absoluteString ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case source,
             author,
             title,
             description,
             url,
             urlToImage,
             publishedAt,
             content
    }
}

extension Article {
    static func sampleTemplate(locale: String) -> Article {
        let locales = ["en", "fr", "ja", "ko", "es"]
        let randomLocale = Int.random(in: 0...locales.count - 1)
        
        var localeToUse = locales[randomLocale]
        if locales.contains(locale) {
            localeToUse = locale
        }
        
        let faker = Faker(locale: localeToUse)
        
        let source = Source(id: nil,
                            name: faker.internet.domainName())
        return Article(source: source,
                              author: faker.name.firstName(),
                              title: faker.lorem.sentence(),
                              description: faker.lorem.paragraphs(amount: 10),
                              url: nil,
                              urlToImage: nil,
                              publishedAt: "\(faker.date.backward(days: Int.random(in: 0...100)))",
                              content: faker.lorem.paragraphs(amount: 10))
    }
}

extension Article: Persistable {
    init(realmObject obj: ArticleObject) {
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
        isBookMarked = obj.isBookMarked
    }
    
    init(bookmarkArticle article: BookMarkArticle) {
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
        isBookMarked = true
    }
    
    func managedObject() -> ArticleObject {
        let obj = ArticleObject()
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
        obj.isBookMarked = isBookMarked
        return obj
    }
    
//    init(bookmarkArticle obj: BookMarkAritcleObject) {
//        id = obj.id
//        source = Source(id: obj.sourceID,
//                        name: obj.sourceName)
//        author = obj.author
//        title = obj.title
//        description = obj.articleDiscription
//        url = obj.url
//        urlToImage = obj.urlToImage
//        publishedAt = obj.publishedAt
//        content = obj.content
//        country = Country(rawValue: obj.country)
//        category = Category(rawValue: obj.category)
//        isBookMarked = true
//    }
}
