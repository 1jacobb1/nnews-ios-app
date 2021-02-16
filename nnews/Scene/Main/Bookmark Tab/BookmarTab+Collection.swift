//
//  BookmarTab+Collection.swift
//  nnews
//
//  Created by Jacob on 2/15/21.
//

import UIKit

extension BookmarkTabViewController:
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputs.bookmarkArticles.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bookmarkedArticles = viewModel.outputs.bookmarkArticles.value
        let bookmarkArticle = bookmarkedArticles[indexPath.row]
        let cell: ArticleCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setUp(article: Article(bookmarkArticle: bookmarkArticle))
        cell.layoutSubviews()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.9
        return CGSize(width: width, height: width * 0.8)
    }
}
