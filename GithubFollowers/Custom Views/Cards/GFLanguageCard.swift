//
//  GFLanguageCard.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 21/9/23.
//

import UIKit

class GFLanguageCard: UIView {
    let stackView = UIStackView()
    let insideStackView = UIStackView()
    let trailingImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 20)
    let secondaryTitleLabel = GFTitleLabel(textAlignment: .right, fontSize: 14)
    let trailingImage = SFSymbols.rightArrow
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUIView()
        configureImageView()
        configureStackView(for: stackView)
        configureStackView(for: insideStackView, isFirst: false)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .secondarySystemBackground
        
        titleLabel.text = NSLocalizedString("language", comment: "")
        let currentLanguage = LanguageManager.shared.currentLanguage
        let secondaryTitleLabelText = currentLanguage[0] == "tr-US" ? "turkish" : "english"
        secondaryTitleLabel.text = NSLocalizedString(secondaryTitleLabelText, comment: "")
    }
    
    private func configureImageView() {
        trailingImageView.image = trailingImage
        trailingImageView.tintColor = .label
    }
    
    private func configureStackView(for view: UIStackView, isFirst: Bool = true) {
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        
        if !isFirst { view.spacing = 6.5 }
        
        view.addArrangedSubview(isFirst ? titleLabel : secondaryTitleLabel)
        view.addArrangedSubview(isFirst ? insideStackView : trailingImageView)
    }
    
    private func setupUI() {
        addSubview(stackView)
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}
