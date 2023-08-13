//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 13/8/23.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true // appbar large title centerTtile false for flutter codes
    }
}
