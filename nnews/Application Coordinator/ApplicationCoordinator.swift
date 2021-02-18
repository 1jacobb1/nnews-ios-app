//
//  ApplicationCoordinator.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit

protocol Coordinator {
    var window: UIWindow { get }
    func start()
}

class ApplicationCoordinator: Coordinator {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        window.makeKeyAndVisible()
    }
}
