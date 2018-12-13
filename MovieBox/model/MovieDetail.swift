//
//  MovieDetail.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class MovieDetail: Movie {
    /*
     audience    Int    총 관람객수
     actor    String    배우진
     duration    Int    영화 상영 길이
     director    String    감독
     synopsis    String    줄거리
     genre    String    영화 장르
     grade    Int    관람등급
     0: 전체이용가 12: 12세 이용가 15: 15세 이용가 19: 19세 이용가
     image    String    포스터 이미지 주소
     reservation_grade    Int    예매순위
     title    String    영화제목
     reservation_rate    Double    예매율
     user_rating    Double    사용자 평점
     date    String    개봉일
     id    String    영화 고유 ID
     */
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let image: String
    
    enum MovieDetailKey: String, CodingKey {
        case audience, actor, duration, director, synopsis, genre, image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieDetailKey.self)
        audience = try container.decode(Int.self, forKey: .audience)
        actor = try container.decode(String.self, forKey: .actor)
        duration = try container.decode(Int.self, forKey: .duration)
        director = try container.decode(String.self, forKey: .director)
        synopsis = try container.decode(String.self, forKey: .synopsis)
        genre = try container.decode(String.self, forKey: .genre)
        image = try container.decode(String.self, forKey: .image)
        try super.init(from: decoder)
    }
    
}
