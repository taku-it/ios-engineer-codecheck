//
//  AppDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let searchRepositoryVC =
            UIStoryboard(name: "SearchRepository", bundle: nil).instantiateInitialViewController() as? SearchRepositoryViewController {
            let navigationController = UINavigationController(rootViewController: searchRepositoryVC)
            
            let model = SearchRepositoryModel()
            let presenter = SearchRepositoryPresenter(view: searchRepositoryVC, model: model)
            searchRepositoryVC.inject(presenter: presenter)
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
        return true
    }

}

