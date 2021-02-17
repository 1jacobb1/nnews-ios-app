//
//  ArticleCollectionCell.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit
import SnapKit
import ReactiveSwift

protocol ArticleCollectionCellDelegate: class {
    func didToggleBookMark(_ source: ArticleCollectionCell, article: Article)
}

class ArticleCollectionCell: UICollectionViewCell, ReusableView {
    /// UI Properties
    var articleContainer = UIView()
    var headlineImageView = UIImageView()
    var bookMarkBtn = UIButton()
    var sourceLbl = UILabel()
    var headlineLbl = UILabel()
    
    var headlineImageHeight: ArticleImageHeight = .large
    weak var delegate: ArticleCollectionCellDelegate?
    
    enum ArticleImageHeight: CGFloat {
        case small = 0.3
        case medium = 0.5
        case large = 0.65
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setUpBinding()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setUpCell()
        setUpBinding()
    }
    
    override func layoutSubviews() {
        articleContainer.layer.cornerRadius = 15
        articleContainer.layer.masksToBounds = true
        articleContainer.layer.backgroundColor = UIColor.white.cgColor
        articleContainer.layer.shadowColor = UIColor.gray.cgColor
        articleContainer.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        articleContainer.layer.shadowRadius = 2.0
        articleContainer.layer.shadowOpacity = 1.0
        articleContainer.layer.masksToBounds = false
        let shadowPath = UIBezierPath(roundedRect: articleContainer.bounds,
                                      cornerRadius: articleContainer.layer.cornerRadius).cgPath
        articleContainer.layer.shadowPath = shadowPath
        
        headlineImageView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private var article: Article?
    func setUp(article: Article) {
        self.article = article
        headlineImageView.setImageWith(url: article.urlToImage)
        sourceLbl.text = article.source?.name
        headlineLbl.text = article.title
        
        bookMarkBtn.isSelected = article.isBookMarked
    }
    
    func getArticle() -> Article? { article }
    
    private func setUpCell() {
        setUpArticleContainer()
        setUpHeadlineImageView()
        setUpSourceLabel()
        setUpHeadlineLabel()
        setUpBookMarkButton()
    }
    
    private func setUpBinding() {
        bookMarkBtn.reactive.controlEvents(.touchUpInside)
            .observeValues { [unowned self] _ in
                guard let article = self.article else { return }
                self.delegate?.didToggleBookMark(self, article: article)
            }
    }
    
    private func setUpArticleContainer() {
        articleContainer.backgroundColor = .white
        
        contentView.addSubview(articleContainer)
        
        articleContainer.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.right.equalToSuperview().inset(5)
        }
    }
    
    private func setUpHeadlineImageView() {
        headlineImageView.contentMode = .scaleAspectFill
        headlineImageView.image = UIImage(systemName: "n.square")
        headlineImageView.clipsToBounds = true
        
        articleContainer.addSubview(headlineImageView)
        
        headlineImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(headlineImageHeight.rawValue)
        }
    }
    
    private func setUpSourceLabel() {
        sourceLbl.font = .boldSystemFont(ofSize: 17)
        sourceLbl.numberOfLines = 1
        
        articleContainer.addSubview(sourceLbl)
        
        sourceLbl.snp.makeConstraints { make in
            make.top.equalTo(headlineImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(20)
        }
    }
    
    private func setUpHeadlineLabel() {
        headlineLbl.numberOfLines = 2
        headlineLbl.font = .boldSystemFont(ofSize: 25)
        
        articleContainer.addSubview(headlineLbl)
        
        headlineLbl.snp.makeConstraints { make in
            make.top.equalTo(sourceLbl.snp.bottom)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setUpBookMarkButton() {
        bookMarkBtn.backgroundColor = .white
        bookMarkBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookMarkBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        bookMarkBtn.imageEdgeInsets = .init(top: 3, left: -8, bottom: 3, right: -8)
        bookMarkBtn.contentMode = .scaleAspectFit
        
        contentView.addSubview(bookMarkBtn)
        
        bookMarkBtn.snp.makeConstraints { make in
            make.top.equalTo(headlineImageView.snp.bottom).offset(15 * headlineImageHeight.rawValue)
            make.right.equalTo(headlineImageView).inset(15 * headlineImageHeight.rawValue)
            make.height.equalTo(25)
            make.width.equalTo(50 * headlineImageHeight.rawValue)
        }
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.layer.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
