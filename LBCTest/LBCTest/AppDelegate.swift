//
//  AppDelegate.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static let shared: AppDelegate = AppDelegate()
    let apiManager: LBCAPIManager = LBCAPIManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        apiManager.fetchCategories()
        
        let initialViewController: LBCHomeViewController = LBCHomeViewController(with: apiManager)
        
        let navigationController = UINavigationController(rootViewController: initialViewController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = UIColor.clear
        navigationController.navigationBar.tintColor = .white
        navigationController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
    
}
