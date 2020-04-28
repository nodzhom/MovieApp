//
//  PersistenceManager.swift
//  MovieAppPractice
//
//  Created by Onur Com on 22.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    static let key = "favorites"
    
    static func updateWith(favorite: Movie, actionType: PersistenceActionType, completed: @escaping (MAError?) -> Void) {
        
        retrieveFaves { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreayInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.title == favorite.title }
                }
                
                completed(save(favorites: favorites))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFaves(completed: @escaping (Result<[Movie],MAError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: key) as? Data else {
            completed(.success([]))
            print("success")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Movie].self, from: favoritesData)
            completed(.success(favorites))
            print("Successfully retrieved data")
        } catch {
            completed(.failure(.unableToFavorite))

        }
    }
    
    static func save(favorites: [Movie]) -> MAError? {
        do {
            let encoder = JSONEncoder()
            let encodedFaves = try encoder.encode(favorites)
            defaults.set(encodedFaves, forKey: key)
            return nil
        } catch {
            return .unableToFavorite
        }
        
    }
}
