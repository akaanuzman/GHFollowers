//
//  GFSettingsCard.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 21/9/23.
//

import UIKit

class GFThemeCard: UIView {
    let stackView = UIStackView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 20)
    let toggle = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        titleLabel.text = "Theme"
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        toggle.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(toggle)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
