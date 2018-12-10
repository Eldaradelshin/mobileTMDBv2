//
//  TMDBRequestClient.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation
import Alamofire

class TMDBRequestClient {
    private let baseURL: URL = URL(string: "https://api.themoviedb.org/3/")!
    private let token: String = "5af1f0932fb5ebe64532f6670ac06d18"
    init() {
    }
    
    func fetchNewMovies(page: Int, startReleaseDate: String, endReleaseDate: String, completion: @escaping (PagedResponse<Movie>) -> Void) {
        let req = Alamofire.request(baseURL.appendingPathComponent("discover/movie"), method: .get, parameters: [
            "page"    : page,
            "api_key" : token,
            "language": "ru-RU",
            "include_adult": "true",
            "primary_release_date.gte": startReleaseDate,
            "primary_release_date.lte": endReleaseDate    ])
        req.validate(statusCode: 200..<300)
        req.validate(contentType: ["application/json"])
        req.responseData { dataResponse in
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            let pagedResponse = try! decoder.decode(PagedResponse<Movie>.self, from: data)
            completion(pagedResponse)
        }
    }
    
}
