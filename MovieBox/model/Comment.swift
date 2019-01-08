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
    private let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    
    func getTimestmap() -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:SS"
        
        return formatter.string(from: date)
    }
    
    enum CommentKey: String, CodingKey {
        case rating, timestamp, writer, contents
        case movieId = "movie_id"
    }
}
