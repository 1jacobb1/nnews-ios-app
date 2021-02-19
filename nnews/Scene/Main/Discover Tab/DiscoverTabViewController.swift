//
//  DiscoverTabViewController.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit
import SnapKit
import SDWebImage
import ReactiveCocoa
import SafariServices

protocol DiscoverTabViewControllerDelegate: class {
    func navigateToSeeMoreArticleWith(category: Category?, country: Country)
}

class DiscoverTabViewController: BaseViewController {
    /// UI Properties
    var scrollView = UIScrollView()
    var headlinesView = ArticlesCollectionView()
    var headlinesPseudolineView = UIView()
    var businessNewsSection = ArticleCategoryWithSeeMoreView()
    var businessNewsView = ArticlesCollectionView()
    var entertainmentNewsSection = ArticleCategoryWithSeeMoreView()
    var entertainmentNewsView = ArticlesCollectionView()
    var generalNewsSection = ArticleCategoryWithSeeMoreView()
    var generalNewsView = ArticlesCollectionView()
    var sportsNewsSection = ArticleCategoryWithSeeMoreView()
    var sportsNewsView = ArticlesCollectionView()
    var healthNewsSection = ArticleCategoryWithSeeMoreView()
    var healthNewsView = ArticlesCollectionView()
    var scienceNewsSection = ArticleCategoryWithSeeMoreView()
    var scienceNewsView = ArticlesCollectionView()
    var technologyNewsSection = ArticleCategoryWithSeeMoreView()
    var technologNewsView = ArticlesCollectionView()
    
    var viewModel: DiscoverTabViewModel
    weak var delegate: DiscoverTabViewControllerDelegate?
    
    init(viewModel: DiscoverTabViewModel) {
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
        setUpBinding()
    }
}

extension DiscoverTabViewController {
    static let headlinesSectionHeight = UIScreen.SCREEN_WIDTH * 0.9
}

class ArticleCategoryWithSeeMoreView: UIView {
    var categoryLbl = UILabel()
    var seeMoreBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setUpView() {
        setUpCategoryLabel()
        setUpSeeMoreButton()
    }
    
    private func setUpCategoryLabel() {
        categoryLbl.text = "Business"
        categoryLbl.font = .boldSystemFont(ofSize: 20)
        
        addSubview(categoryLbl)
        
        categoryLbl.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().offset(15)
        }
    }
    
    private func setUpSeeMoreButton() {
        seeMoreBtn.setTitle("See All", for: .normal)
        seeMoreBtn.setTitleColor(.systemBlue, for: .normal)
        seeMoreBtn.titleLabel?.font = .systemFont(ofSize: 15)
        
        addSubview(seeMoreBtn)
        
        seeMoreBtn.snp.makeConstraints { make in
            make.left.lessThanOrEqualTo(categoryLbl.snp.right).offset(15)
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }
}
