//
//  Movie.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class Movie: Decodable {
/*
     grade    Int    관람등급
     0: 전체이용가
     12: 12세 이용가
     15: 15세 이용가
     19: 19세 이용가
     thumb    String    포스터 이미지 섬네일 주소
     reservation_grade    Int    예매순위
     title    String    영화제목
     reservation_rate    Double    예매율
     user_rating    Double    사용자 평점
     date    String    개봉일
     id    String    영화 고유 ID
 */
    let id: String
    let grade: MovieGrade.RawValue
    let thumb: String?
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    
    enum MovieGrade: Int {
        case all = 0
        case child = 12
        case youngth = 15
        case adult = 19
    }
    
    enum MovieKey: String, CodingKey {
        case id, grade, title, date, thumb
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        
        id = try container.decode(String.self, forKey: .id)
        grade = try container.decode(Int.self, forKey: .grade)
        thumb = try container.decode(String.self, forKey: .thumb)
        reservationGrade = try container.decode(Int.self, forKey: .reservationGrade)
        title = try container.decode(String.self, forKey: .title)
        reservationRate = try container.decode(Double.self, forKey: .reservationRate)
        userRating = try container.decode(Double.self, forKey: .userRating)
        date = try container.decode(String.self, forKey: .date)
    }
}
