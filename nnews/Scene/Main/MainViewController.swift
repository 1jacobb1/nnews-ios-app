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
        let discoverNav = UINavigationController(rootViewController: discoverTab)
        
        let bookmarkTab = BookmarkTabViewController(viewModel: BookmarkTabViewModel())
        bookmarkTab.title = "Bookmark"
        bookmarkTab.tabBarItem.title = "Bookmark"
        bookmarkTab.tabBarItem.image = UIImage(systemName: "bookmark")
        bookmarkTab.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
        let bookmarkNav = UINavigationController(rootViewController: bookmarkTab)
        
        viewControllers = [discoverNav, bookmarkNav]
    }
}
