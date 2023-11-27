//
//  SettingsVC.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 18/9/23.
//

import UIKit

class SettingsVC: UIViewController {
    let stackView = UIStackView()
    let themeCard = GFThemeCard()
    let languageCard = GFLanguageCard()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupUI()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // appbar large title centerTtile false for flutter codes
    }

    private func setupUI() {
        view.addSubviews(themeCard, languageCard)

        themeCard.translatesAutoresizingMaskIntoConstraints = false
        languageCard.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uiViewOnTapped))
        languageCard.addGestureRecognizer(tapGesture)

        let padding: CGFloat = 20
        let height: CGFloat = 60

        NSLayoutConstraint.activate([
            themeCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            themeCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            themeCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            themeCard.heightAnchor.constraint(equalToConstant: height),

            languageCard.topAnchor.constraint(equalTo: themeCard.bottomAnchor, constant: padding),
            languageCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            languageCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            languageCard.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    @objc private func uiViewOnTapped() {
        let languageSelectionVC = LanguageSelectionVC()
        languageSelectionVC.modalPresentationStyle = .overFullScreen
        languageSelectionVC.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(languageSelectionVC, animated: true)
    }
}
