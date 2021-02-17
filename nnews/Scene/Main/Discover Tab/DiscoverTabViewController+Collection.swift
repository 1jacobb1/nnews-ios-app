//
//  DiscoverTabViewController+Collection.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit

extension DiscoverTabViewController:
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var articles: [Article] = []
        if collectionView == headlinesView.collectionView {
            articles = viewModel.outputs.headlineArticles.value
        } else if collectionView == businessNewsView.collectionView {
            articles = viewModel.outputs.businessArticles.value
        } else if collectionView == entertainmentNewsView.collectionView {
            articles = viewModel.outputs.entertainmentArticles.value
        }
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var articles: [Article] = []
        
        if collectionView == headlinesView.collectionView {
            articles = viewModel.outputs.headlineArticles.value
        } else if collectionView == businessNewsView.collectionView {
            articles = viewModel.outputs.businessArticles.value
        } else if collectionView == entertainmentNewsView.collectionView {
            articles = viewModel.outputs.entertainmentArticles.value
        }
        
        if collectionView == headlinesView.collectionView ||
            collectionView == businessNewsView.collectionView ||
            collectionView == entertainmentNewsView.collectionView {
            let cell: ArticleCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            if collectionView != headlinesView.collectionView {
                cell.headlineImageHeight = .small
            }
            cell.delegate = self
            cell.layoutSubviews()
            
            if articles.count <= indexPath.row {
                return cell
            }
            
            cell.setUp(article: articles[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.bounds.size
        var size = CGSize.zero
        if collectionView == headlinesView.collectionView {
            let width = collectionViewSize.width - 15
            let height = collectionViewSize.height - 15
            size = CGSize(width: width, height: height)
        } else if collectionView == businessNewsView.collectionView ||
                    collectionView == entertainmentNewsView.collectionView {
            let width = (collectionViewSize.width - 15) / 2
            let height = (collectionViewSize.height - 15) / 2
            size = CGSize(width: width, height: height)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if collectionView == headlinesView.collectionView {
            let headlinesCount = viewModel.outputs.headlineArticles.value.count
            if indexPath.item >= headlinesCount - 1 {
                viewModel.inputs.loadMoreHeadlines()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ArticleCollectionCell,
              let article = cell.getArticle() else { return }
        presentNewsDetail(with: article)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == headlinesView.collectionView {
            headlinesView.collectionView.snapToCenter(view: headlinesView)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate && scrollView == headlinesView.collectionView {
            headlinesView.collectionView.snapToCenter(view: headlinesView)
        }
    }
}

extension DiscoverTabViewController: ArticleCollectionCellDelegate {
    func didToggleBookMark(_ source: ArticleCollectionCell, article: Article) {
        viewModel.inputs.bookMarkArticle(article, articleSection: "")
    }
}
