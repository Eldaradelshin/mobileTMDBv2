//
//  Movie.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let vote_average: Float?
    let poster_path: String?
    let release_date: String?
    let overview: String
    let original_language: String?
    let genre_ids: [Int]
    
}

extension Movie : Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
    return
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.vote_average == rhs.vote_average &&
        lhs.poster_path == rhs.poster_path &&
        lhs.release_date == rhs.release_date &&
        lhs.overview == rhs.overview &&
        lhs.original_language == rhs.original_language
        
    }
}
