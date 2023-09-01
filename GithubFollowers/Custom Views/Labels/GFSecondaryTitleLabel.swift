//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 25/8/23.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = .systemFont(ofSize: fontSize, weight: .medium)
    }

    private func configure() -> Void {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail // textOverFlow. if the text does not fit it shows the text as dot dot dot .....
        translatesAutoresizingMaskIntoConstraints = false
    }

}
