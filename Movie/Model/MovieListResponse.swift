//
//  MovieListResponse.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Foundation

struct MovieListResponse: Codable {
    var page: Int
    
    var results: [Movie]
    
    var totalPages: Int
    
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
