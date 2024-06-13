//
//  ContentViewModel.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Combine
import Paging

class ContentViewModel: ObservableObject {
    private let movieRepository: MovieRepository
    
    lazy var movies: AnyPublisher<PagingData<Movie>, Never> = movieRepository.getMovieResultStream()
    
    init(_ movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
}
