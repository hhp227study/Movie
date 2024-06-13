//
//  MoviePagingSource.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Foundation
import Paging

class MoviePagingSource: PagingSource<Int, Movie> {
    let movieService: MovieService
    
    override func getFreshKey(state: PagingState<Int, Movie>) -> Int? {
        if let anchorPosition = state.anchorPosition {
            if let prevKey = state.closestPageToPosition(anchorPosition)?.prevKey {
                return prevKey + 1
            } else if let nextKey = state.closestPageToPosition(anchorPosition)?.nextKey {
                return nextKey - 1
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    override func load(params: PagingSource<Int, Movie>.LoadParams<Int>) async -> PagingSource<Int, Movie>.LoadResult<Int, Movie> {
        do {
            try! await Task.sleep(nanoseconds: 2_000_000_000)
            let nextPage = params.getKey() ?? 1
            let movieListResponse = try await movieService.getPopularMovie(nextPage, "a86526535fa0fc12d269041691633aed")
            return LoadResult<Int, Movie>.Page(
                data: movieListResponse.results,
                prevKey: nextPage == 1 ? nil : nextPage - 1,
                nextKey: movieListResponse.page + 1
            )
        } catch {
            return LoadResult<Int, Movie>.Error(error: error)
        }
    }
    
    init(_ movieService: MovieService) {
        self.movieService = movieService
    }
}
