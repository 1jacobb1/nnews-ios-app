//
//  BookmarkTabViewController+View.swift
//  nnews
//
//  Created by Jacob on 2/15/21.
//

import UIKit

extension BookmarkTabViewController {
    func setUpScene() {
        setUpBookmarkCollectionView()
    }
    
    private func setUpBookmarkCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let minLineSpacing: CGFloat = 15
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = minLineSpacing
        bookmarkCollection.setCollectionViewLayout(layout, animated: false)
        bookmarkCollection.backgroundColor = Asset.Colors.moreArticleTblBackground.color
        bookmarkCollection.delegate = self
        bookmarkCollection.dataSource = self
        bookmarkCollection.register(ArticleCollectionCell.self)
        bookmarkCollection.contentInset.left = minLineSpacing
        bookmarkCollection.contentInset.right = minLineSpacing
        
        view.addSubview(bookmarkCollection)
        
        bookmarkCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
