//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 4/9/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
