//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 27/8/23.
//

import UIKit

/// For UserInfoVC buttons to event handling
protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    /// Used to event handling  for one item in button click
    weak var delegate: GFRepoItemVCDelegate!

    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(
            color: .systemPurple,
            title: NSLocalizedString("github_profile", comment: ""),
            systemImage: SFSymbols.followers!)
    }

    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
