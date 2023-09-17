//
//  FavoriteCellTableViewCell.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 31/8/23.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID: String = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        #warning("cached bug!!! fix me later")
        Task {
            let image = await NetworkManager.shared.downloadImage(from: favorite.avatarUrl) ?? avatarImageView.placherholderImage

            avatarImageView.image = image
        }
    }

    private func configure() {
        addSubviews(avatarImageView, usernameLabel)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),

            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),

        ])
    }
}
