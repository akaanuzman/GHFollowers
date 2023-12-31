//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 26/8/23.
//

import UIKit

enum ItemInfoType { case repos; case gists; case followers; case following }

class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        countLabel.text = String(count)
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = NSLocalizedString("public_repos", comment: "")
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = NSLocalizedString("public_gists", comment: "")
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = NSLocalizedString("followers", comment: "")
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = NSLocalizedString("following", comment: "")
        }
    }
}
