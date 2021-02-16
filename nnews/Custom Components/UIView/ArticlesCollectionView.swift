//
//  ArticlesCollectionView.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit

class ArticlesCollectionView: UIView {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setUpView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setUpView() {
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let minLineSpacing: CGFloat = 15
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = minLineSpacing
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .clear
        collectionView.register(ArticleCollectionCell.self)
        collectionView.contentInset.left = minLineSpacing
        collectionView.contentInset.right = minLineSpacing
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.left.right.equalToSuperview()
        }
    }
}
