//
//  Response.swift
//  MovieBox
//
//  Created by juhee on 14/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

struct ResponseMovies: Decodable {
    let movies: [Movie]
}

struct ResponseComments: Decodable {
    let movieId: String
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case comments
        case movieId = "movie_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movieId = try container.decode(String.self, forKey: .movieId)
        comments = try container.decode([Comment].self, forKey: .comments)
    }
}
