//
//  AppDelegate.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        startFlow()
        return true
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = .black
    }
    
    private func startFlow() {
        window?.rootViewController = UINavigationController(rootViewController: GifSearchAssembly.createModule())
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}

