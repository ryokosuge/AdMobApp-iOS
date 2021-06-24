//
//  AppDelegate.swift
//  AdMobApp
//
//  Created by ryokosuge on 2020/03/03.
//  Copyright © 2020 fluct, inc. All rights reserved.
//

import UIKit
import AppTrackingTransparency
import AdSupport
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                GADMobileAds.sharedInstance().start { status in
                    print("==========")
                    status.adapterStatusesByClassName.forEach { (value) in
                        print("key:     \(value.key)")
                        print("status:  \(value.value)")
                    }
                    print("==========")
                }
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                print("idfa:    \(idfa)")
            }
        } else {
            GADMobileAds.sharedInstance().start { status in
                print("==========")
                status.adapterStatusesByClassName.forEach { (value) in
                    print("key:     \(value.key)")
                    print("status:  \(value.value)")
                }
                print("==========")
            }
            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            print("idfa:    \(idfa)")
        }
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

