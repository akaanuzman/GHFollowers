//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 17/9/23.
//

import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }

    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
