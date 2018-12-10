//
//  genresRuDict.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

struct GenresRuDict {
    static let genresDict: [Int : String] = [ 28    : "боевик",
                                              12    : "приключения",
                                              16    : "мультфильм",
                                              35    : "комедия",
                                              80    : "криминал",
                                              99    : "документальный",
                                              18    : "драма",
                                              10751 : "семейный",
                                              14    : "фентези",
                                              36    : "история",
                                              27    : "ужасы",
                                              10402 : "музыка",
                                              9648  : "детектив",
                                              10749 : "мелодрама",
                                              878   : "фантастика",
                                              10770 : "телевизионный фильм",
                                              53    : "триллер",
                                              10752 : "военный",
                                              37    : "вестерн"                ]
    
    static func genresString(inputGenres: [Int]) -> String {
        var genresString = String()
        for id in inputGenres {
            let genreForId = genresDict[id]!
            genresString.append("\(genreForId), ")
        }
        return genresString
    }

}

