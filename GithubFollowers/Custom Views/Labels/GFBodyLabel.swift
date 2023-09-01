//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 13/8/23.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }

    private func configure() -> Void {
        textColor = .secondaryLabel
        font = .preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping // The value that indicates wrapping occurs at word boundaries, unless the word doesn’t fit on a single line.
        translatesAutoresizingMaskIntoConstraints = false
    }
}
