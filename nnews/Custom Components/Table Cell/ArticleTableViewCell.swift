//
//  ArticleTableViewCell.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import UIKit
import CocoaLumberjack
import SwiftDate

class ArticleTableViewCell: UITableViewCell, ReusableView {
    // MARK: - UI
    var containerView = UIView()
    var sourceLbl = UILabel()
    var publishedAtLbl = UILabel()
    var bookMarkBtn = UIButton()
    var titleLbl = UILabel()
    var articleImgView = UIImageView()
    
    // MARK: - Properties
    private var article: Article?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setUp(article: Article) {
        self.article = article
        setUpCellWithArticleContent()
    }
    
    func getArticle() -> Article? { article }
    
    private func setUpCell() {
        backgroundColor = .clear
        setUpContainerView()
        setUpSourceLabel()
        setUpPublishedAtLabel()
        setUpBookmarkButton()
        setUpTitleLabel()
        setUpArticleImageView()
    }
    
    private func setUpContainerView() {
        containerView.backgroundColor = .white
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func setUpSourceLabel() {
        sourceLbl.numberOfLines = 0
        sourceLbl.font = .boldSystemFont(ofSize: 22)
        
        containerView.addSubview(sourceLbl)
        
        sourceLbl.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(8)
        }
    }
    
    private func setUpPublishedAtLabel() {
        publishedAtLbl.numberOfLines = 1
        publishedAtLbl.font = .systemFont(ofSize: 12)
        publishedAtLbl.textColor = .lightGray
        
        containerView.addSubview(publishedAtLbl)
        
        publishedAtLbl.snp.makeConstraints { make in
            make.top.equalTo(sourceLbl.snp.bottom).offset(5)
            make.left.equalTo(sourceLbl).offset(3)
        }
    }
    
    private func setUpBookmarkButton() {
        bookMarkBtn.backgroundColor = .white
        bookMarkBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookMarkBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        bookMarkBtn.imageEdgeInsets = .init(top: 3, left: -8, bottom: 3, right: -8)
        bookMarkBtn.contentMode = .scaleAspectFit
        
        containerView.addSubview(bookMarkBtn)
        
        bookMarkBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(25)
            make.width.equalTo(50)
        }
    }
    
    private func setUpTitleLabel() {
        titleLbl.numberOfLines = 0
        titleLbl.font = .systemFont(ofSize: 17)
        
        containerView.addSubview(titleLbl)
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(publishedAtLbl.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(8)
        }
    }
    
    private func setUpArticleImageView() {
        articleImgView.contentMode = .scaleToFill
        articleImgView.clipsToBounds = true
        
        containerView.addSubview(articleImgView)
        
        articleImgView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(0)
            make.height.equalTo(180)
        }
    }
    
    private func setUpCellWithArticleContent() {
        sourceLbl.text = article?.source?.name
        let timeAgo = Date(article?.publishedAt ?? "")?.timeAgo()
        publishedAtLbl.text = timeAgo != nil ? "\(timeAgo!) ago." : ""
        bookMarkBtn.isSelected = article?.isBookMarked ?? false
        titleLbl.text = article?.title
        articleImgView.setImageWith(url: article?.urlToImage)
        updateImageViewHeight(article?.urlToImage == nil ? 0 : 180)
        articleImgView.isHidden = article?.urlToImage == nil
    }
    
    private func updateImageViewHeight(_ height: CGFloat) {
        articleImgView.snp.updateConstraints { update in
            update.height.equalTo(height)
            update.bottom.equalToSuperview().inset(height == 0 ? 5 : 0)
        }
    }
}
