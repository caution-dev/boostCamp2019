//
//  Comment.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

struct Comment: Codable {
    /*
     rating    Double    평점
     timestamp    Double    작성일시 UNIX Timestamp 값
     writer    String    작성자
     movie_id    String    영화 고유ID
     contents    String    한줄평 내용
     */
    
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    
    enum CommentKey: String, CodingKey {
        case rating, timestamp, writer, contents
        case movieId = "movie_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CommentKey.self)
        rating = try container.decode(Double.self, forKey: .rating)
        timestamp = try container.decode(Double.self, forKey: .timestamp)
        writer = try container.decode(String.self, forKey: .writer)
        movieId = try container.decode(String.self, forKey: .movieId)
        contents = try container.decode(String.self, forKey: .contents)
    }
}
