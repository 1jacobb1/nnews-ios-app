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
        
        viewModel.inputs.viewDidLoad()
    }
    
    private func handleArticleOn(collectionView: UICollectionView) {
        collectionView.reloadData()
    }
}
