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
    let secondaryTitleLabel = GFTitleLabel(textAlignment: .right, fontSize: 14)
    let toggle = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIView()
        configureStackView()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUIView() {
        titleLabel.text = NSLocalizedString("dark_theme", comment: "")
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(toggle)
    }

    private func setupUI() {
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        toggle.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])

        toggle.isOn = PersistenceManager.isDarkTheme()

        toggle.addTarget(self, action: #selector(switchOnChanged), for: .valueChanged)
    }

    @objc private func switchOnChanged(switchBtn: UISwitch) {
        if switchBtn.isOn {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            }

        } else {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }

        PersistenceManager.setDarkTheme(to: switchBtn.isOn)
    }
}
