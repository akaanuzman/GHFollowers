//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 13/8/23.
//

import SafariServices
import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: String) {
        guard let url = URL(string: url) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        
        let schemeTypes = [URLSchemeTypes.http, URLSchemeTypes.https]
        guard schemeTypes.contains(url.scheme?.lowercased() ?? "") else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func addFollowerToFavoriteList(on favorite: Follower) {
        PersistenceManager.updateWith(on: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorites this user 🎉", buttonTitle: "Hooray!")
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
