//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 13/8/23.
//

import SafariServices
import UIKit

extension UIViewController {
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultGFAlert() {
        let alertVC = GFAlertVC(alertTitle: "Something Went Wrong",
                                message: "We were unable to complete your task at this time. Please try again.",
                                buttonTitle: "OK")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: String) {
        guard let url = URL(string: url) else {
            presentGFAlert(title: "Invalid URL",
                           message: "The url attached to this user is invalid",
                           buttonTitle: "OK")
            return
        }
        
        let schemeTypes = [URLSchemeTypes.http, URLSchemeTypes.https]
        guard schemeTypes.contains(url.scheme?.lowercased() ?? "") else {
            presentGFAlert(title: "Invalid URL",
                           message: "The url attached to this user is invalid",
                           buttonTitle: "OK")
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
                self.presentGFAlert(
                    title: NSLocalizedString("success", comment: ""),
                    message: NSLocalizedString("success_added_user", comment: ""),
                    buttonTitle: NSLocalizedString("hooray", comment: ""))
                return
            }
            
            self.presentGFAlert(
                title: NSLocalizedString("something_wrong", comment: ""),
                message: error.rawValue,
                buttonTitle: NSLocalizedString("ok", comment: ""))
        }
    }
}
