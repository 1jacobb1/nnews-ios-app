//
//  MainViewController.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let discoverTab = DiscoverTabViewController(viewModel: DiscoverTabViewModel())
        discoverTab.title = "Top News"
        discoverTab.tabBarItem.title = "Discover"
        discoverTab.tabBarItem.image = UIImage(systemName: "n.square")
        discoverTab.tabBarItem.selectedImage = UIImage(systemName: "n.square.fill")
        discoverTab.delegate = self
        let discoverNav = UINavigationController(rootViewController: discoverTab)
        
        let bookmarkTab = BookmarkTabViewController(viewModel: BookmarkTabViewModel())
        bookmarkTab.title = "Bookmark"
        bookmarkTab.tabBarItem.title = "Bookmark"
        bookmarkTab.tabBarItem.image = UIImage(systemName: "bookmark")
        bookmarkTab.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
        let bookmarkNav = UINavigationController(rootViewController: bookmarkTab)
        
        viewControllers = [discoverNav, bookmarkNav]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension MainViewController: DiscoverTabViewControllerDelegate {
    func navigateToSeeMoreArticleWith(category: Category?, country: Country) {
        let viewModel = MoreArticlesViewModel(articleCountry: country, articleCategory: category)
        let seeMoreVC = MoreArticlesViewController(viewModel: viewModel)
        seeMoreVC.title = category?.rawValue.capitalized ?? "News".capitalized
        navigationController?.pushViewController(seeMoreVC, animated: true)
    }
}
