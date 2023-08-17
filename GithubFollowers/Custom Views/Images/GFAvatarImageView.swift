//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 15/8/23.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placherholderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    // This is required for storyboard
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placherholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
