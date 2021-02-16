//
//  BookmarkTab+View.swift
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
        bookmarkCollection.collectionView.delegate = self
        bookmarkCollection.collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        bookmarkCollection.collectionView.setCollectionViewLayout(layout, animated: false)
        
        view.addSubview(bookmarkCollection)
        
        bookmarkCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
