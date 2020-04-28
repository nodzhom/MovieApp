//
//  FavoritesNC.swift
//  MovieAppPractice
//
//  Created by Onur Com on 17.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    var titles = [String]()
    var useAssets = [String]()
    var favorites = [Movie]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFaves()
    }
    
    func getFaves() {
        PersistenceManager.retrieveFaves { [weak self]result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
//                for favorite in favorites {
//                    self.titles.append(favorite.title)
//                    self.useAssets.append(favorite.poster_path)
//                }
            case .failure(let error):
                self.presentMAAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateUI(with favorites: [Movie]) {
        if favorites.isEmpty {
            self.presentMAAlertOnMainThread(title: "No favorites", message: "You haven't added any favorites yet", buttonTitle: "OK")
        } else {
            self.favorites = favorites
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
            
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.frame         = view.bounds
        tableView.rowHeight     = 190
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(MAFavoriteCell.self, forCellReuseIdentifier: MAFavoriteCell.reuseID)
    }
    
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MAFavoriteCell.reuseID) as! MAFavoriteCell
        cell.titleLabel.text = favorites[indexPath.row].title
        cell.posterView.downloadImage(fromURL: "https://image.tmdb.org/t/p/w780/" + favorites[indexPath.row].poster_path)
        cell.posterView.contentMode = .center
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentMAAlertOnMainThread(title: "Unable to remove favorite", message: error.rawValue, buttonTitle: "Ok")
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = favorites[indexPath.row]
        let destVC = MAMovieDetailVC(movie: movie)
        present(destVC, animated: true, completion: nil)
    }
    
}
