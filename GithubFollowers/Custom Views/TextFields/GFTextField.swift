//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 10/8/23.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // this is a storyboard required initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false // disable auto constraints
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor // UIColor converted to CGColor becasue layer.borderColor is a CGColor
        
        textColor = .label // default color for text
        tintColor = .label // this is a cursor color
        textAlignment = .center
        font = .preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true // if text is too long, it will shrink to fit (this is like a AutoSizeText in Flutter)
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing // if you write a letter or word in textfield it shows x icon right side on the textfield
        placeholder = "Enter a username"
    }
}
