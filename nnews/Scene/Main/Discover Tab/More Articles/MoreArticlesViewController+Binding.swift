//
//  MoreArticlesViewController+Binding.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import UIKit
import ReactiveSwift

extension MoreArticlesViewController {
    func setUpBinding() {
        viewModel.outputs.articles
            .signal
            .observe(on: uiSchedule)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                self.articleTableView.reloadData()
            }
        
        viewModel.inputs.viewDidLoad()
    }
}
