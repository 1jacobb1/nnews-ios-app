//
//  MoreArticlesViewModel.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import ReactiveSwift
import CocoaLumberjack
import RealmSwift

protocol MoreArticlesViewModelInputs {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
    func fetchMoreArticle()
    func didSearchInputChange(_ keyword: String)
    func didSearchBarSearchButtonClicked()
    func didSearchBarCancelButtonClicked()
}

protocol MoreArticlesViewModelOutputs {
    var articles: MutableProperty<[Article]> { get }
    var apiRequestState: MutableProperty<APIRequestState> { get }
}

protocol MoreArticlesViewModelTypes {
    var inputs: MoreArticlesViewModelInputs { get }
    var outputs: MoreArticlesViewModelOutputs { get }
}

class MoreArticlesViewModel: MoreArticlesViewModelTypes,
 MoreArticlesViewModelOutputs,
 MoreArticlesViewModelInputs {
    var inputs: MoreArticlesViewModelInputs { return self }
    var outputs: MoreArticlesViewModelOutputs { return self }
    
    var articles: MutableProperty<[Article]>
    var apiRequestState: MutableProperty<APIRequestState> = MutableProperty(.notStarted)
    
    private var articleNotificationToken: NotificationToken?
    private var articleCategory: MutableProperty<Category?>
    private var articleCountry: MutableProperty<Country>
    
    init(articleCountry country: Country = .philippines,
         articleCategory category: Category?) {
        articles = MutableProperty([])
        articleCategory = MutableProperty(category)
        articleCountry = MutableProperty(country)
        
        viewDidLoadProp.signal
            .observeValues { [unowned self] _ in
                self.requestFetchArticleApi()
            }
        
        viewDidAppearProp.signal
            .observeValues { [unowned self] _ in
                self.setUpArticleNotificationToken()
            }
        
        viewDidDisappearProp.signal
            .observeValues { [unowned self] _ in
                self.articleNotificationToken?.invalidate()
            }
        
        fetchMoreArticleProp.signal
            .filter { self.hasNext }
            .observeValues { [unowned self] _ in
                self.requestFetchArticleApi()
            }

        didSearchInputChangeProp.signal
            .filter { !$0.isEmpty }
            .observeValues { [unowned self] keyword in
                let result = self.articles.value.filter { article -> Bool in
                    article.author?.contains(keyword) ?? false ||
                        article.category?.rawValue.contains(keyword) ?? false ||
                        article.content?.contains(keyword) ?? false
                }
                self.searchResult.value = result
            }

        articles <~ searchResult

        articles <~ didSearchBarCancelButtonClickedProp.signal
            .map { _ -> [Article] in
                guard let test = self.getDefaultArticles() else { return [] }
                return test.map { Article(realmObject: $0) }
            }
    }
    
    private var viewDidLoadProp = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProp.value = ()
    }
    
    private var viewDidAppearProp = MutableProperty(())
    func viewDidAppear() {
        viewDidAppearProp.value = ()
    }
    
    private var viewDidDisappearProp = MutableProperty(())
    func viewDidDisappear() {
        viewDidDisappearProp.value = ()
    }
    
    private var fetchMoreArticleProp = MutableProperty(())
    func fetchMoreArticle() {
        fetchMoreArticleProp.value = ()
    }
    
    private var searchResult: MutableProperty<[Article]> = MutableProperty([])
    private var didSearchInputChangeProp = MutableProperty("")
    func didSearchInputChange(_ keyword: String) {
        didSearchInputChangeProp.value = keyword
    }

    private var didSearchBarSearchButtonClickedProp = MutableProperty(())
    func didSearchBarSearchButtonClicked() {
        didSearchBarSearchButtonClickedProp.value = ()
    }

    private var didSearchBarCancelButtonClickedProp = MutableProperty(())
    func didSearchBarCancelButtonClicked() {
        didSearchBarCancelButtonClickedProp.value = ()
    }

    private func getDefaultArticles() -> Results<ArticleObject>? {
        guard let realm = try? LocalDataManager.getInstance() else { return nil }
        var predicateFilter = Predicates.eq(k: .country, v: self.articleCountry.value.rawValue)
            .and(Predicates.isNotEmpty(k: .rawUrlToImage))
        if let category = self.articleCategory.value {
            predicateFilter = predicateFilter.and(Predicates.eq(k: .category, v: category.rawValue))
        }
        return realm.objects(ArticleObject.self)
            .filter(predicateFilter)
            .sorted(byKeyPath: Query.publishedAt.rawValue, ascending: false)
    }

    private func setUpArticleNotificationToken() {
        guard let results = getDefaultArticles() else { return }
        articleNotificationToken = results.observe(on: LocalDataManager.thread) { changes in
            switch changes {
            case .initial(let articleObjects),
                 .update(let articleObjects, _, _, _):
                self.articles.value = articleObjects
                    .filter { $0.urlToImage != nil }
                    .map { Article(realmObject: $0) }
                break
            case .error(let err):
                DDLogError("Error: \(err)")
                break
            }
        }
    }
    
    private var page: Int = 1
    private var hasNext: Bool = false
    private func requestFetchArticleApi() {
        guard !apiRequestState.value.isRequesting else { return }
        apiRequestState.value = .requesting
        APIEndPoint.getTopHeadlines(from: .philippines,
                                    category: articleCategory.value,
                                    inPage: page,
                                    perPage: MoreArticlesViewModel.perPage)
            .startWithResult { result in
                switch result {
                case .success(let response):
                    self.saveFetchedArticleToRealm(response.articles)
                    let currentArticleCount = self.page * MoreArticlesViewModel.perPage
                    self.hasNext = currentArticleCount < response.totalResults
                    if self.hasNext {
                        self.page += 1
                    }
                    self.apiRequestState.value = .success
                    break
                case .failure(let moyaError):
                    self.apiRequestState.value = .failed(err: moyaError)
                    break
                }
            }
    }
    
    private func saveFetchedArticleToRealm(_ articles: [Article]) {
        let articleObjects = articles.map { article -> ArticleObject in
            var newArticle = article
            newArticle.id = article.title ?? ""
            newArticle.category = articleCategory.value
            newArticle.country = articleCountry.value
            return newArticle.managedObject()
        }
        LocalDataManager.save(type: articleObjects)
    }
}

extension MoreArticlesViewModel {
    static let perPage: Int = 20
}
