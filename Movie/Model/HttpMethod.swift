//
//  HttpMethod.swift
//  Movie
//
//  Created by hhp227 on 2023/03/09.
//

import Foundation

enum HttpMethod {
    case get
    case post
    case put
    case delete
    
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}
