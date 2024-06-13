//
//  ContentView.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import SwiftUI
import Paging

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel(.getInstance(movieService: MovieServiceImpl()))
    
    var body: some View {
        NavigationView {
            MovieList(lazyPagingItems: viewModel.movies.collectAsLazyPagingItems())
                .navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MovieList: View {
    @ObservedObject var lazyPagingItems: LazyPagingItems<Movie>
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(lazyPagingItems) { movie in
                    MovieImage(movie: movie!)
                }
                HStack {
                    if lazyPagingItems.loadState.refresh is LoadState.Loading {
                        ProgressView()
                    } else if lazyPagingItems.loadState.append is LoadState.Loading {
                        ProgressView()
                    } else if lazyPagingItems.loadState.refresh is LoadState.Error {
                        
                    } else if lazyPagingItems.loadState.append is LoadState.Error {
                        ErrorItem(message: "error", onClickRetry: {})
                    }
                }
            }
        }.refreshable {
            print("refresh")
        }
    }
}

struct MovieImage: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + (movie.backdropPath ?? ""))) { result in
                switch result {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fill)
                case .failure:
                    Image(systemName: "photo").resizable()
                        .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fit)
                case .empty:
                    ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ErrorItem: View {
    var message: String
    
    var onClickRetry: () -> Void
    
    var body: some View {
        HStack {
            Text(message)
            Button(action: onClickRetry) {
                Text("Retry")
            }
        }
        .padding(16)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
