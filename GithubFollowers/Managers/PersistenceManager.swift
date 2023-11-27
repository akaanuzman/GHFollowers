//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 30/8/23.
//

import Foundation

enum PersistenceActionType { case add; case remove }

enum PersistenceManager {
    private static let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
        static let darkTheme = "darkTheme"
    }

    static func updateWith(on favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):

                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }

                    favorites.append(favorite)

                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }

                completed(save(favorites: favorites))
            case .failure(let failure):
                completed(failure)
            }
        }
    }

    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }

    static func setDarkTheme(to isDark: Bool) {
        print("Setting dark theme to \(isDark)")

        defaults.set(isDark, forKey: Keys.darkTheme)
    }

    static func isDarkTheme() -> Bool {
        return defaults.bool(forKey: Keys.darkTheme)
    }

    static func changeLanguage(to language: String) {
        defaults.set([language], forKey: "AppleLanguages")
        LanguageManager.shared.currentLanguage = getCurrentLanguage()
        print(language)
        let locale = Locale(identifier: language == "tr-US" ? "tr" : "en")
        guard let path = Bundle.main.path(forResource: locale.identifier, ofType: "lproj")
        else { return }
        let localizedBundle = Bundle(path: path)
        localizedBundle?.localizedString(forKey: "", value: "", table: nil)
        defaults.synchronize()
    }

    static func getCurrentLanguage() -> [String] {
        let cachedLanguage = defaults.stringArray(forKey: "AppleLanguages")
        if let currentLanguage = cachedLanguage {
            return currentLanguage
        }

        return ["en"]
    }
}
