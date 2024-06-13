//
//  MovieRepository.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Combine
import Paging

class MovieRepository {
    private let movieService: MovieService
    
    func getMovieResultStream() -> AnyPublisher<PagingData<Movie>, Never> {
        return Pager(PagingConfig(pageSize: MovieRepository.NETWORK_PAGE_SIZE)) {
            MoviePagingSource(self.movieService)
        }.publisher
    }
    
    private init(_ movieService: MovieService) {
        self.movieService = movieService
    }
    
    private static let NETWORK_PAGE_SIZE = 15
    
    private static var instance: MovieRepository? = nil
    
    static func getInstance(movieService: MovieService) -> MovieRepository {
        if let instance = self.instance {
            return instance
        } else {
            let movieRepository = MovieRepository(movieService)
            self.instance = movieRepository
            return movieRepository
        }
    }
}
