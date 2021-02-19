//
//  BaseViewController.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit
import ReactiveSwift
import SafariServices

class BaseViewController: UIViewController {
    let uiSchedule = UIScheduler()
    let backGroundSchedule = QueueScheduler()

    func presentNewsDetail(with article: Article) {
        guard let url = article.url else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .popover
        present(safariVC, animated: true)
    }
}
