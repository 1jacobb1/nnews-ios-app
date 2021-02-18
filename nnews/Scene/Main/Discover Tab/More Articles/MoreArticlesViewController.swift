//
//  MoreArticlesViewController.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import UIKit

class MoreArticlesViewController: BaseViewController {
    // MARK: - UI
    var articleTableView = UITableView()
    
    // MARK: - Properties
    var viewModel: MoreArticlesViewModel
    
    init(viewModel: MoreArticlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        setUpScene()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.inputs.viewDidDisappear()
    }
}
