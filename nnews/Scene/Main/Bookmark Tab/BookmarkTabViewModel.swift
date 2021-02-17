//
//  BookmarkTabViewModel.swift
//  nnews
//
//  Created by Jacob on 2/11/21.
//

import Foundation
import ReactiveSwift
import RealmSwift
import CocoaLumberjack

protocol BookmarkTabViewModelInputs {
    func viewDidLoad()
    func bookMarkArticle(_ article: BookMarkArticle)
}

protocol BookmarkTabViewModelOutputs {
    var bookmarkArticles: MutableProperty<[BookMarkArticle]> { get }
}

protocol BookmarkTabViewModelTypes {
    var inputs: BookmarkTabViewModelInputs { get }
    var outputs: BookmarkTabViewModelOutputs { get }
}

class BookmarkTabViewModel: BookmarkTabViewModelTypes,
    BookmarkTabViewModelOutputs,
    BookmarkTabViewModelInputs {
    var inputs: BookmarkTabViewModelInputs { return self }
    var outputs: BookmarkTabViewModelOutputs { return self }
    
    var bookmarkArticles: MutableProperty<[BookMarkArticle]> = MutableProperty([])
    
    init() {
        viewDidLoadProp.signal.observeValues { [unowned self] _ in
            self.bookmarkNotifToken = self.bookmarkArticleToken()
        }
        
        bookMarkArticleProp.signal.observeValues { article in
            LocalDataManager.delete(type: article.managedObject())
        }
    }
    
    private var viewDidLoadProp = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProp.value = ()
    }
    
    private var bookMarkArticleProp = MutableProperty(BookMarkArticle())
    func bookMarkArticle(_ article: BookMarkArticle) {
        bookMarkArticleProp.value = article
    }
    
    private var bookmarkNotifToken: NotificationToken?
    private func bookmarkArticleToken() -> NotificationToken? {
        guard let realm = try? LocalDataManager.getInstance() else { return nil }
        let result = realm.objects(BookMarkArticleObject.self)
        return result.observe(on: LocalDataManager.thread) { changes in
            switch changes {
            case .initial(let objects),
                 .update(let objects, _, _, _):
                debugPrint("bookmark_article_objects: \(objects)")
                self.bookmarkArticles.value = objects.map { BookMarkArticle(realmObject: $0) }
                break
            case .error(let error):
                DDLogError("error: \(error)")
                break
            }
        }
    }
}
