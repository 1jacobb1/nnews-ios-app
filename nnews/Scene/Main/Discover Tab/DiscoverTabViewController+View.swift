//
//  DiscoverTabViewController+View.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit

extension DiscoverTabViewController {
    func setUpScene() {
        setUpScrollView()
        setUpHeadlinesView()
        setUpHeadlinesPseudolineView()
        setUpBusinessNewsSection()
        setUpBusinessNewsView()
        setUpEntertainmentNewsSection()
        setUpEntertainmentNewsView()
        setUpGeneralNewsSection()
        setUpGeneralNewsView()
        setUpSportsNewsSection()
        setUpSportsNewsView()
        setUpHealthNewsSection()
        setUpHealthNewsView()
    }
    
    private func setUpScrollView() {
        scrollView.backgroundColor = Asset.Colors.moreArticleTblBackground.color
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.bottom.equalTo(view.safeArea.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setUpHeadlinesView() {
        headlinesView.collectionView.delegate = self
        headlinesView.collectionView.dataSource = self
        headlinesView.collectionView.register(ArticleCollectionCell.self)
        
        scrollView.addSubview(headlinesView)
        
        headlinesView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.right.equalTo(view.snp.right)
            make.height.equalTo(DiscoverTabViewController.headlinesSectionHeight)
        }
    }
    
    private func setUpHeadlinesPseudolineView() {
        headlinesPseudolineView.backgroundColor = .lightGray
        
        scrollView.addSubview(headlinesPseudolineView)
        
        headlinesPseudolineView.snp.makeConstraints { make in
            make.top.equalTo(headlinesView.snp.bottom).offset(5)
            make.left.right.equalTo(headlinesView).inset(15)
            make.height.equalTo(0.5)
        }
    }
    
    private func setUpBusinessNewsSection() {
        businessNewsSection.categoryLbl.text = "Business"
        businessNewsSection.categoryLbl.font = .boldSystemFont(ofSize: 20)
        
        scrollView.addSubview(businessNewsSection)
        
        businessNewsSection.snp.makeConstraints { make in
            make.top.equalTo(headlinesPseudolineView.snp.bottom).offset(10)
            make.left.equalTo(headlinesView.snp.left).offset(15)
            make.right.equalTo(headlinesView.snp.right)
        }
    }
    
    private func setUpBusinessNewsView() {
        businessNewsView.collectionView.delegate = self
        businessNewsView.collectionView.dataSource = self
        
        scrollView.addSubview(businessNewsView)
        
        businessNewsView.snp.makeConstraints { make in
            make.top.equalTo(businessNewsSection.snp.bottom)
            make.left.right.equalTo(headlinesView)
            make.height.equalTo(370)
        }
    }
    
    private func setUpEntertainmentNewsSection() {
        entertainmentNewsSection.categoryLbl.text = "Entertainment"
        entertainmentNewsSection.categoryLbl.font = .boldSystemFont(ofSize: 20)
        
        scrollView.addSubview(entertainmentNewsSection)
        
        entertainmentNewsSection.snp.makeConstraints { make in
            make.top.equalTo(businessNewsView.snp.bottom).offset(10)
            make.left.equalTo(businessNewsView.snp.left).offset(15)
            make.right.equalTo(businessNewsView.snp.right)
        }
    }
    
    private func setUpEntertainmentNewsView() {
        entertainmentNewsView.collectionView.delegate = self
        entertainmentNewsView.collectionView.dataSource = self
        
        scrollView.addSubview(entertainmentNewsView)
        
        entertainmentNewsView.snp.makeConstraints { make in
            make.top.equalTo(entertainmentNewsSection.snp.bottom)
            make.left.right.equalTo(headlinesView)
            make.height.equalTo(370)
        }
    }

    private func setUpGeneralNewsSection() {
        generalNewsSection.categoryLbl.text = "General"
        generalNewsSection.categoryLbl.font = .boldSystemFont(ofSize: 20)

        scrollView.addSubview(generalNewsSection)

        generalNewsSection.snp.makeConstraints { make in
            make.top.equalTo(entertainmentNewsView.snp.bottom).offset(10)
            make.left.equalTo(entertainmentNewsView.snp.left).offset(15)
            make.right.equalTo(entertainmentNewsView.snp.right)
        }
    }

    private func setUpGeneralNewsView() {
        generalNewsView.collectionView.delegate = self
        generalNewsView.collectionView.dataSource = self

        scrollView.addSubview(generalNewsView)

        generalNewsView.snp.makeConstraints { make in
            make.top.equalTo(generalNewsSection.snp.bottom)
            make.left.right.equalTo(headlinesView)
            make.height.equalTo(370)
        }
    }

    private func setUpSportsNewsSection() {
        sportsNewsSection.categoryLbl.text = "Sports"
        sportsNewsSection.categoryLbl.font = .boldSystemFont(ofSize: 20)

        scrollView.addSubview(sportsNewsSection)

        sportsNewsSection.snp.makeConstraints { make in
            make.top.equalTo(generalNewsView.snp.bottom).offset(10)
            make.left.equalTo(generalNewsView.snp.left).offset(15)
            make.right.equalTo(generalNewsView.snp.right)
        }
    }

    private func setUpSportsNewsView() {
        sportsNewsView.collectionView.delegate = self
        sportsNewsView.collectionView.dataSource = self

        scrollView.addSubview(sportsNewsView)

        sportsNewsView.snp.makeConstraints { make in
            make.top.equalTo(sportsNewsSection.snp.bottom)
            make.left.right.equalTo(headlinesView)
            make.height.equalTo(370)
        }
    }

    private func setUpHealthNewsSection() {
        healthNewsSection.categoryLbl.text = "Health"
        healthNewsSection.categoryLbl.font = .boldSystemFont(ofSize: 20)

        scrollView.addSubview(healthNewsSection)

        healthNewsSection.snp.makeConstraints { make in
            make.top.equalTo(sportsNewsView.snp.bottom).offset(10)
            make.left.equalTo(sportsNewsView.snp.left).offset(15)
            make.right.equalTo(sportsNewsView.snp.right)
        }
    }

    private func setUpHealthNewsView() {
        healthNewsView.collectionView.delegate = self
        healthNewsView.collectionView.dataSource = self

        scrollView.addSubview(healthNewsView)

        healthNewsView.snp.makeConstraints { make in
            make.top.equalTo(healthNewsSection.snp.bottom)
            make.left.right.equalTo(headlinesView)
            make.height.equalTo(370)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
