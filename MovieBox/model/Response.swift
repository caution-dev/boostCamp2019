//
//  Response.swift
//  MovieBox
//
//  Created by juhee on 14/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

struct ResponseMovies: Codable {
    let movies: [Movie]
}

struct ResponseComments: Codable {
    let movieId: String
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case comments
        case movieId = "movie_id"
    }
}
