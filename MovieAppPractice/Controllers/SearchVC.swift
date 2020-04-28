//
//  SearchNC.swift
//  MovieAppPractice
//
//  Created by Onur Com on 17.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDataSource!
    var networkManager = NetworkManager()
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top Movies"
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout(in: view))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MAMovieCell.self, forCellWithReuseIdentifier: MAMovieCell.reuseID)
        view.addSubview(collectionView)
        
        configureSearchController()
        networkManager.delegate = self
        networkManager.getTopMovies()
        
    }
    
    func updateData(on Movies: [Movie]) {
        movies = Movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.delegate                               = self
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Search for a movie"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    func createCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width                           = view.bounds.width
        let padding: CGFloat                = 22
        let minimumItemSpacing: CGFloat     = 40
        let availableWidth                  = width - (padding * 2) - (minimumItemSpacing )
        let itemWidth                       = availableWidth / 2
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 160)
        
        
        return flowLayout
    }
    

}

extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if isSearching {
//            return filteredMovies.count
//        } else {
//            return movies.count
//        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAMovieCell.reuseID, for: indexPath) as! MAMovieCell
        cell.movieNameLabel.text = movies[indexPath.item].title
        cell.moviePosterView.downloadImage(fromURL: "https://image.tmdb.org/t/p/w500/" + movies[indexPath.item].poster_path)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = MAMovieDetailVC(movie: movies[indexPath.item])
        let navController   = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
    }
}

extension SearchVC: NetworkManagerDelegate {
    func didUpdateMovies(_ networkManager: NetworkManager, movies: [Movie]) {
        DispatchQueue.main.async {
             self.movies = movies
                print(movies)
            self.collectionView.reloadData()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print("\(error)")
        return
    }
    
    
}

extension SearchVC: UISearchBarDelegate , UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
                //filteredMovies.removeAll()
            
                updateData(on: movies)
                
                return
            }
            
            isSearching = true
            filteredMovies = movies.filter { $0.title.lowercased().contains(filter.lowercased()) }
            updateData(on: filteredMovies)
            
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.dismiss(animated: true, completion: nil)
        networkManager.getTopMovies()
    }
    
}
