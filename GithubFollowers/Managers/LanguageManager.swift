//
//  LanguageManager.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 27/11/23.
//

import Foundation

final class LanguageManager {
    static let shared = LanguageManager()
    lazy var currentLanguage: [String] = PersistenceManager.getCurrentLanguage()

    private init() {}
}
