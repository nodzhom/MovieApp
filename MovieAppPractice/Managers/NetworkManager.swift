//
//  NetworkManager.swift
//  MovieAppPractice
//
//  Created by Onur Com on 19.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

protocol NetworkManagerDelegate {
    func didUpdateMovies(_ networkManager: NetworkManager, movies: [Movie])
    func didFailWithError(error: Error)
}

class NetworkManager {
    let cache = NSCache<NSString, UIImage>()
    
    var delegate: NetworkManagerDelegate?
    
    
    static let shared = NetworkManager()
    let baseURL = "https://api.themoviedb.org/3/discover/movie"
    let apiKey = Secrets.apiKey
    let posterSize = "https://image.tmdb.org/t/p/w500/"
    
    func getTopMovies() {
        
        let endpoint = baseURL + apiKey + "&sort_by=popularity.desc"
        if let url = URL(string: endpoint) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let movies = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.delegate?.didUpdateMovies(self, movies: movies.results)
                            }
                        }
                        catch {
                            self.delegate?.didFailWithError(error: error)
                            
                        }
                    }
                }
            }
            task.resume()
                
        }
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return

        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }

    
}
