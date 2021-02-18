//
//  MoreArticlesViewController+Table.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import UIKit

extension MoreArticlesViewController: 
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.articles.value.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let articles = viewModel.outputs.articles.value
        guard articles.count > indexPath.row else { return cell }
        let article = articles[indexPath.row]
        cell.setUp(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let articles = viewModel.outputs.articles.value
        if indexPath.row >= articles.count - 5 {
            viewModel.inputs.fetchMoreArticle()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ArticleTableViewCell,
              let article = cell.getArticle() else { return }
        presentNewsDetail(with: article)
    }
}
