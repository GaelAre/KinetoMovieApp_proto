//
//  Movie.swift
//  Pod 1
//
//  Created by sunqiao lin on 4/17/23.
//

import Foundation

struct MovieResponse: Decodable {
    var results:[Movie] = []
}

struct Movie: Decodable {
    let original_title : String
    let overview: String
    let poster_path: URL
    
    
    let vote_average : Float
    let vote_count : Int
    let popularity : Float
}
