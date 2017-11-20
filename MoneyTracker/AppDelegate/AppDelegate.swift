//
//  AppDelegate.swift
//  MoneyTracker
//
//  Created by Zesium on 11/3/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flowController = ApplicationFlowController()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        flowController.showPasswordLogin(appDelegate: self)
    }

}
