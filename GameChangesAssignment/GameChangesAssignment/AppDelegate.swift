//
//  AppDelegate.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 12/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootNavigationController: UINavigationController?
    
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        rootNavigationController = UINavigationController()
        window?.rootViewController = rootNavigationController
        
        // Coordinator setup
        appCoordinator = AppCoordinator(navigationController: rootNavigationController!)
        appCoordinator?.start()
        
        
        window?.makeKeyAndVisible()
        return true
        
    }

}

