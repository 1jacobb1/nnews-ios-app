//
//  DiscoverTabViewModel.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import ReactiveSwift
import RealmSwift
import CocoaLumberjack
import SwiftDate

protocol DiscoverTabViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func refreshHeadlines()
    func loadMoreHeadlines()
    func bookMarkArticle(_ article: Article, articleSection section: String)
}

protocol DiscoverTabViewModelOutputs {
    var headlineRequestParam: MutableProperty<ArticleRequestParam> { get }
    var headlineArticles: MutableProperty<[Article]> { get }
    var businessArticleRequestParam: MutableProperty<ArticleRequestParam> { get }
    var businessArticles: MutableProperty<[Article]> { get }
    var entertainmentArticleRequestParam: MutableProperty<ArticleRequestParam> { get }
    var entertainmentArticles: MutableProperty<[Article]> { get }
    var generalArticleRequestParam: MutableProperty<ArticleRequestParam> { get }
    var generalArticles: MutableProperty<[Article]> { get }
    var sportsArticleRequestParam: MutableProperty<ArticleRequestParam> { get }
    var sportsArticles: MutableProperty<[Article]> { get }
    var healthArticleRequestParam: MutableProperty<ArticleRequestParam> { get }
    var healthArticles: MutableProperty<[Article]> { get }
}

protocol DiscoverTabViewModelTypes {
    var inputs: DiscoverTabViewModelInputs { get }
    var outputs: DiscoverTabViewModelOutputs { get }
}

struct ArticleRequestParam {
    var country: Country = .philippines
    var category: Category? = nil
    var currentPage: Int = 1
    var perPage: Int = 30
    var hasNext: Bool = false
    var apiRequestState: APIRequestState = .notStarted
}

class DiscoverTabViewModel: DiscoverTabViewModelTypes,
    DiscoverTabViewModelOutputs,
    DiscoverTabViewModelInputs {
    var inputs: DiscoverTabViewModelInputs { return self }
    var outputs: DiscoverTabViewModelOutputs { return self }
    
    var headlineRequestParam = MutableProperty(ArticleRequestParam(country: .philippines))
    var headlineArticles: MutableProperty<[Article]> = MutableProperty([])
    var businessArticleRequestParam = MutableProperty(ArticleRequestParam(country: .philippines,
                                                                          category: .business,
                                                                          perPage: 20))
    var businessArticles: MutableProperty<[Article]> = MutableProperty([])
    var entertainmentArticleRequestParam = MutableProperty(ArticleRequestParam(country: .philippines,
                                                                               category: .entertainment,
                                                                               perPage: 20))
    var entertainmentArticles: MutableProperty<[Article]> = MutableProperty([])
    var generalArticleRequestParam = MutableProperty(ArticleRequestParam(country: .philippines,
                                                                         category: .general,
                                                                         perPage: 20))
    var generalArticles: MutableProperty<[Article]> = MutableProperty([])
    var sportsArticleRequestParam = MutableProperty(ArticleRequestParam(country: .philippines,
                                                                        category: .sports,
                                                                        perPage: 20))
    var sportsArticles: MutableProperty<[Article]> = MutableProperty([])
    var healthArticleRequestParam = MutableProperty(ArticleRequestParam(country: .philippines,
                                                                        category: .health,
                                                                        perPage: 20))
    var healthArticles: MutableProperty<[Article]> = MutableProperty([])
    
    init() {
        viewDidLoadProp.signal
            .observeValues { [unowned self] _ in
                self.setUpHeadlineNotificationToken()
                self.apiRequestHeadlines(requestParam: self.headlineRequestParam)
                self.apiRequestHeadlines(requestParam: self.businessArticleRequestParam)
                self.apiRequestHeadlines(requestParam: self.entertainmentArticleRequestParam)
                self.apiRequestHeadlines(requestParam: self.generalArticleRequestParam)
                self.apiRequestHeadlines(requestParam: self.sportsArticleRequestParam)
                self.apiRequestHeadlines(requestParam: self.healthArticleRequestParam)
            }
        
        refreshHeadlinesProp.signal
            .observeValues { [unowned self] _ in
                self.headlineRequestParam.value.currentPage = 1
                self.apiRequestHeadlines(requestParam: self.headlineRequestParam)
                self.businessArticleRequestParam.value.currentPage = 1
                self.apiRequestHeadlines(requestParam: self.businessArticleRequestParam)
                self.entertainmentArticleRequestParam.value.currentPage = 1
                self.apiRequestHeadlines(requestParam: self.entertainmentArticleRequestParam)
                self.generalArticleRequestParam.value.currentPage = 1
                self.apiRequestHeadlines(requestParam: self.generalArticleRequestParam)
                self.sportsArticleRequestParam.value.currentPage = 1
                self.apiRequestHeadlines(requestParam: self.sportsArticleRequestParam)
                self.healthArticleRequestParam.value.currentPage = 1
                self.apiRequestHeadlines(requestParam: self.healthArticleRequestParam)
            }
        
        loadMoreHeadlinesProp.signal
            .observeValues { [unowned self] _ in
                self.apiRequestHeadlines(requestParam: self.headlineRequestParam)
            }
        
        bookMarkArticleProp.signal
            .skipNil()
            .compactMap { $0.article }
            .observeValues(processBookMark(article:))
    }
    
    private var viewDidLoadProp = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProp.value = ()
    }
    
    private var viewWillAppearProp = MutableProperty(())
    func viewWillAppear() {
        viewWillAppearProp.value = ()
    }
    
    private var viewDidAppearProp = MutableProperty(())
    func viewDidAppear() {
        viewDidAppearProp.value = ()
    }
    
    private var viewWillDisappearProp = MutableProperty(())
    func viewWillDisappear() {
        viewWillDisappearProp.value = ()
    }
   
    private var viewDidDisappearProp = MutableProperty(())
    func viewDidDisappear() {
        viewDidDisappearProp.value = ()
    }
    
    private var refreshHeadlinesProp = MutableProperty(())
    func refreshHeadlines() {
        refreshHeadlinesProp.value = ()
    }
    
    private var loadMoreHeadlinesProp = MutableProperty(())
    func loadMoreHeadlines() {
        loadMoreHeadlinesProp.value = ()
    }
    
    private var bookMarkArticleProp = MutableProperty<(article: Article, section: String)?>(nil)
    func bookMarkArticle(_ article: Article, articleSection section: String) {
        bookMarkArticleProp.value = (article: article, section: section)
    }
    
    private var headlineNotificationToken: NotificationToken?
    private func setUpHeadlineNotificationToken() {
        guard let realm = try? LocalDataManager.getInstance() else { return }
        let results = realm.objects(ArticleObject.self)
        headlineNotificationToken = results.observe(on: LocalDataManager.thread) { changes in
            switch changes {
            case .initial(let articleObjects),
                 .update(let articleObjects, _, _, _):
                
                DDLogInfo("update articles: \(articleObjects)")
                
                self.headlineArticles.value = articleObjects
                    .filter { $0.category.isEmpty && !$0.rawUrlToImage.isEmpty }
                    .map { Article(realmObject: $0) }
                
                self.businessArticles.value = articleObjects
                    .filter { $0.category == Category.business.rawValue && !$0.rawUrlToImage.isEmpty }
                    .prefix(6)
                    .map { Article(realmObject: $0) }
                
                self.entertainmentArticles.value = articleObjects
                    .filter { $0.category == Category.entertainment.rawValue && !$0.rawUrlToImage.isEmpty }
                    .prefix(6)
                    .map { Article(realmObject: $0) }

                self.generalArticles.value = articleObjects
                    .filter { $0.category == Category.general.rawValue && !$0.rawUrlToImage.isEmpty }
                    .prefix(6)
                    .map { Article(realmObject: $0) }

                self.sportsArticles.value = articleObjects
                    .filter { $0.category == Category.sports.rawValue && !$0.rawUrlToImage.isEmpty }
                    .prefix(6)
                    .map { Article(realmObject: $0) }

                self.healthArticles.value = articleObjects
                    .filter { $0.category == Category.health.rawValue && !$0.rawUrlToImage.isEmpty }
                    .prefix(6)
                    .map { Article(realmObject: $0) }
                
                break
            case .error(let realmErr):
                DDLogError("[DisoverTabModel] setUpHeadlineNotificationToken, error: \(realmErr)")
                break
            }
        }
    }
    
    private func apiRequestHeadlines(requestParam: MutableProperty<ArticleRequestParam>) {
        let query = requestParam.value
        guard !query.apiRequestState.isRequesting else { return }
        requestParam.value.apiRequestState = .requesting
        
        let country = query.country
        let category = query.category
        let inPage = query.currentPage
        let perPage = query.perPage
        
        APIEndPoint.getTopHeadlines(from: country,
                                    category: category,
                                    inPage: inPage,
                                    perPage: perPage)
            .start { result in
                switch result {
                case .value(let newsResponse):
                    requestParam.value.apiRequestState = .success
                    
                    if inPage == 1 {
                        LocalDataManager.thread.async {
                            guard let realm = try? LocalDataManager.getInstance() else { return }
                            let dateWeekAgo = Date() - 7.days
                            try? realm.write {
                                let articlesToDelete = realm.objects(ArticleObject.self)
                                    .filter {
                                        $0.country == country.rawValue &&
                                        $0.category == category?.rawValue ?? "" &&
                                        $0.publishedDateStringToDate < dateWeekAgo
                                    }
                                realm.delete(articlesToDelete)
                            }
                        }
                    }
                    
                    let articleObjects = newsResponse.articles.map { article -> ArticleObject in
                        var newArticle = article
                        newArticle.id = article.title ?? ""
                        newArticle.category = category
                        newArticle.country = country
                        return newArticle.managedObject()
                    }
                    LocalDataManager.save(type: articleObjects)
                    
                    let currentArticleCount = query.currentPage * query.perPage
                    requestParam.value.hasNext = currentArticleCount < newsResponse.totalResults
                    
                    if requestParam.value.hasNext {
                        requestParam.value.currentPage += 1
                    }
                    break
                case .failed(let moyaErr):
                    requestParam.value.apiRequestState = .failed(err: moyaErr)
                    break
                default: break
                }
            }
    }
    
    private func processBookMark(article: Article) {
        var articleToBookmark = article
        articleToBookmark.isBookMarked = !article.isBookMarked
        let bookmarkArticle = BookMarkArticle(article: articleToBookmark)
        if articleToBookmark.isBookMarked {
            LocalDataManager.save(type: bookmarkArticle.managedObject())
        } else {
            LocalDataManager.delete(type: bookmarkArticle.managedObject())
        }
        LocalDataManager.save(type: articleToBookmark.managedObject())
    }
}
