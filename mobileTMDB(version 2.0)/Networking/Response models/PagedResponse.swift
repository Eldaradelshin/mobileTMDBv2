//
//  PagedResponse.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

struct PagedResponse<T : Codable> : Codable {
    let page : Int
    let total_results: Int
    let total_pages : Int
    let results: [T]
    
}
