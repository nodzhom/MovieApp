//
//  MAError.swift
//  MovieAppPractice
//
//  Created by Onur Com on 25.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import Foundation

enum MAError: String, Error {
    
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreayInFavorites  = "You've already favorited this user. You must really like them!"
}
