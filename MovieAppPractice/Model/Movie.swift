//
//  Movie.swift
//  MovieAppPractice
//
//  Created by Onur Com on 19.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [Movie]
    
}

struct Movie: Codable, Identifiable, Hashable {
    
    var id: Int
    
    let genre_ids: [Int]
    let poster_path: String
    let title: String
    let url: String?
    let vote_average: Double
    let overview: String
    let release_date: String
}
