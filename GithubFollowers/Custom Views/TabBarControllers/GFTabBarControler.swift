//
//  GFTabBarControler.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 31/8/23.
//

import UIKit

class GFTabBarControler: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesListNC(), createSettingsNC()]
    }

    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = NSLocalizedString("search", comment: "")
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
    }

    private func createFavoritesListNC() -> UINavigationController {
        let favorlitesListVC = FavoritesListVC()
        favorlitesListVC.title = NSLocalizedString("favorites", comment: "")
        favorlitesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        return UINavigationController(rootViewController: favorlitesListVC)
    }

    private func createSettingsNC() -> UINavigationController {
        let settingsVC = SettingsVC()
        settingsVC.title = NSLocalizedString("settings", comment: "")
        settingsVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("settings", comment: ""),
            image: SFSymbols.settings,
            selectedImage: SFSymbols.settings)

        return UINavigationController(rootViewController: settingsVC
        )
    }
}
