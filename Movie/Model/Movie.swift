//
//  Movie.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Foundation

struct Movie: Codable {
    var adult: Bool
    
    var backdropPath: String?
    
    var genreIds: [Int]
    
    var id: Int
    
    var originalLanguage: String
    
    var originalTitle: String
    
    var overview: String
    
    var popularity: Double
    
    var posterPath: String
    
    var releaseDate: String
    
    var title: String?
    
    var video: Bool
    
    var voteAverage: Float
    
    var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult, id, overview, popularity, title, video
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
