//
//  MovieError.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Foundation

enum MovieError: Error {
    case jsonDecodeError(message: String)
}
