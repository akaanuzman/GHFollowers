//
//  GFAlertContainerView.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 1/9/23.
//

import UIKit

class GFAlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
