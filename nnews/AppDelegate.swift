//
//  AppDelegate.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//
// https://newsapi.org/docs/endpoints/top-headlines

import UIKit
import IQKeyboardManagerSwift
import CocoaLumberjack

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        DDOSLogger.configure()
        LocalDataManager.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = ApplicationCoordinator(window: window)
        guard let coordinator = appCoordinator else { return false }
        coordinator.start()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

