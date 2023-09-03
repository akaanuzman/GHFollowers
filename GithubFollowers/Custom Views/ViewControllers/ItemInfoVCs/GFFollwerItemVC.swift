//
//  GFFollwerItemVC.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 27/8/23.
//

import UIKit

/// For UserInfoVC buttons to event handling
protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollwers(for user: User)
}

class GFFollwerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate!

    init(user: User ,delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollwers(for: user)
    }
}
