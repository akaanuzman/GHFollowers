//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 15/8/23.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    static let reuseID: String = "FollowerCell"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) -> Void {
        contentConfiguration = UIHostingConfiguration {
            FollowerView(follower: follower)
        }
    }
}
