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
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
    }

    private func createFavoritesListNC() -> UINavigationController {
        let favorlitesListVC = FavoritesListVC()
        favorlitesListVC.title = "Favorites"
        favorlitesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        return UINavigationController(rootViewController: favorlitesListVC)
    }

    private func createSettingsNC() -> UINavigationController {
        let settingsVC = SettingsVC()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings",
                                             image: SFSymbols.settings,
                                             selectedImage: SFSymbols.settings)

        return UINavigationController(rootViewController: settingsVC
        )
    }
}
