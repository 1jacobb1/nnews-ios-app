//
//  BookmarkTab+Bindings.swift
//  nnews
//
//  Created by Jacob on 2/15/21.
//

import UIKit
import ReactiveSwift

extension BookmarkTabViewController {
    func setUpBindings() {
        viewModel.outputs.bookmarkArticles
            .signal
            .observe(on: uiSchedule)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                self.bookmarkCollection.collectionView.reloadData()
            }
        
        viewModel.inputs.viewDidLoad()
    }
}
