//
//  MATabBarController.swift
//  MovieAppPractice
//
//  Created by Onur Com on 17.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class MATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewControllers = [createSearchNC(), createFavoritesNC()]
        UITabBar.appearance().tintColor = .systemPurple
    

 
    }
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = ""
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }

    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }

}
