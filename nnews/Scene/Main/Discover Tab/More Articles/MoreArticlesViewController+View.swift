//
//  MoreArticlesViewController+View.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import UIKit

extension MoreArticlesViewController {
    func setUpScene() {
        view.backgroundColor = .white
        setUpArticleTableView()
    }
    
    private func setUpArticleTableView() {
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.register(ArticleTableViewCell.self)
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.estimatedRowHeight = UITableView.automaticDimension
        articleTableView.separatorInset = .zero
        articleTableView.backgroundColor = Asset.Colors.moreArticleTblBackground.color
        articleTableView.separatorStyle = .none

        view.addSubview(articleTableView)
        
        articleTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.bottom.left.right.equalToSuperview()
        }
    }
}
