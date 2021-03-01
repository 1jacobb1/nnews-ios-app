//
//  MoreArticlesViewController.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import UIKit
import SafariServices

class MoreArticlesViewController: BaseViewController {
    // MARK: - UI
    var articleTableView = UITableView()
    var searchController = UISearchController(searchResultsController: nil)
    
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
        setUpNavigationBar()
        setUpSearchController()
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

    private func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
    }

    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
    }
}

extension MoreArticlesViewController: UISearchResultsUpdating,
                                      UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.inputs.didSearchInputChange(searchController.searchBar.text ?? "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputs.didSearchBarSearchButtonClicked()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputs.didSearchBarCancelButtonClicked()
    }
}
