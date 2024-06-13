//
//  MovieService.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Foundation

protocol MovieService {
    func getPopularMovie(_ pageNumber: Int, _ apiKey: String) async throws -> MovieListResponse
}

class MovieServiceImpl: MovieService {
    let baseUrl = "https://api.themoviedb.org/"
    
    func getPopularMovie(_ pageNumber: Int, _ apiKey: String) async throws -> MovieListResponse {
        let params = ["page": pageNumber, "api_key": apiKey].map { "\($0)=\($1)" }.joined(separator: "&")
        var urlRequest = URLRequest(url: URL(string: baseUrl + "3/movie/popular" + "?" + params)!)
        urlRequest.httpMethod = HttpMethod.get.method
        urlRequest.timeoutInterval = 10
        let (data, response) = try! await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
            fatalError(response.description)
        }
        guard let movieListResponse = try? JSONDecoder().decode(MovieListResponse.self, from: data) else {
            throw MovieError.jsonDecodeError(message: "json decode error occur")
        }
        return movieListResponse
    }
}
