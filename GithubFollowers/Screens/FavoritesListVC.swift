//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 10/8/23.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // appbar large title centerTtile false for flutter codes
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
