//
//  BookmarkTabViewController.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit

class BookmarkTabViewController: BaseViewController {
    // MARK: - UI
    var bookmarkCollection: UICollectionView = UICollectionView(frame: .zero,
                                                                collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Properties
    var viewModel: BookmarkTabViewModel
    
    init(viewModel: BookmarkTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setUpScene()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        setUpBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.viewDidAppear()
    }
}
