//
//  DiscoverTabViewController+Binding.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import ReactiveSwift
import UIKit

extension DiscoverTabViewController {
    func setUpBinding() {
        setSeeMoreNavigationOn(sectionView: businessNewsSection, category: .business)
        setSeeMoreNavigationOn(sectionView: entertainmentNewsSection, category: .entertainment)
        setSeeMoreNavigationOn(sectionView: generalNewsSection, category: .general)
        setSeeMoreNavigationOn(sectionView: sportsNewsSection, category: .sports)
        setSeeMoreNavigationOn(sectionView: healthNewsSection, category: .health)
        setSeeMoreNavigationOn(sectionView: scienceNewsSection, category: .science)
        setSeeMoreNavigationOn(sectionView: technologyNewsSection, category: .technology)
        
        viewModel.outputs.headlineArticles
            .signal
            .observe(on: uiSchedule)
            .map { _ -> UICollectionView in
                return self.headlinesView.collectionView
            }
            .observeValues(handleArticleOn(collectionView:))
        
        viewModel.outputs.businessArticles
            .signal
            .observe(on: uiSchedule)
            .map { _ -> UICollectionView in
                return self.businessNewsView.collectionView
            }
            .observeValues(handleArticleOn(collectionView:))
        
        viewModel.outputs.entertainmentArticles
            .signal
            .observe(on: uiSchedule)
            .map { _ -> UICollectionView in
                return self.entertainmentNewsView.collectionView
            }
            .observeValues(handleArticleOn(collectionView:))
        
        viewModel.outputs.generalArticles
            .signal
            .observe(on: uiSchedule)
            .map { _ -> UICollectionView in
                return self.generalNewsView.collectionView
            }
            .observeValues(handleArticleOn(collectionView:))

        viewModel.outputs.sportsArticles
            .signal
            .observe(on: uiSchedule)
            .map { _ -> UICollectionView in
                return self.sportsNewsView.collectionView
            }
            .observeValues(handleArticleOn(collectionView:))

        viewModel.outputs.healthArticles
            .signal
            .observe(on: uiSchedule)
            .map { _ -> UICollectionView in
                return self.healthNewsView.collectionView
            }
            .observeValues(handleArticleOn(collectionView:))

        viewModel.inputs.viewDidLoad()
    }
    
    private func handleArticleOn(collectionView: UICollectionView) {
        collectionView.reloadData()
    }
    
    private func setSeeMoreNavigationOn(sectionView: ArticleCategoryWithSeeMoreView, category: Category) {
        sectionView.seeMoreBtn.reactive
            .controlEvents(.touchUpInside)
            .observeValues { [unowned self] _ in
                self.delegate?.navigateToSeeMoreArticleWith(category: category,
                                                            country: .philippines)
            }
    }
}
