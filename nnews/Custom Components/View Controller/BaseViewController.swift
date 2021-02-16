//
//  BaseViewController.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit
import ReactiveSwift

class BaseViewController: UIViewController {
    let uiSchedule = UIScheduler()
    let backGroundSchedule = QueueScheduler()
}
