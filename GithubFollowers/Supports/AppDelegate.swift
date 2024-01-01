//
//  AppDelegate.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 9/8/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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

extension Bundle {
    static func swizzleLocalization() {
        let orginalSelector = #selector(localizedString(forKey:value:table:))
        guard let orginalMethod = class_getInstanceMethod(self, orginalSelector) else { return }

        let mySelector = #selector(myLocaLizedString(forKey:value:table:))
        guard let myMethod = class_getInstanceMethod(self, mySelector) else { return }

        if class_addMethod(self, orginalSelector, method_getImplementation(myMethod), method_getTypeEncoding(myMethod)) {
            class_replaceMethod(self, mySelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod))
        } else {
            method_exchangeImplementations(orginalMethod, myMethod)
        }
    }

    @objc private func myLocaLizedString(forKey key: String,value: String?, table: String?) -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let bundlePath = Bundle.main.path(forResource: appDelegate.currentDelegate, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath) else {
                return Bundle.main.myLocaLizedString(forKey: key, value: value, table: table)
        }
        return bundle.myLocaLizedString(forKey: key, value: value, table: table)
    }
}
