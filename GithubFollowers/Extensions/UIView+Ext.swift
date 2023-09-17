//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 4/9/23.
//

import UIKit

extension UIView {
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }

    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
