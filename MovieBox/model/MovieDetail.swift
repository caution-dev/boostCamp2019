//
//  MovieDetail.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation
import UIKit
//
//class MovieDetail: Movie {
//    /*
//     audience    Int    총 관람객수
//     actor    String    배우진
//     duration    Int    영화 상영 길이
//     director    String    감독
//     synopsis    String    줄거리
//     genre    String    영화 장르
//     grade    Int    관람등급
//     0: 전체이용가 12: 12세 이용가 15: 15세 이용가 19: 19세 이용가
//     image    String    포스터 이미지 주소
//     reservation_grade    Int    예매순위
//     title    String    영화제목
//     reservation_rate    Double    예매율
//     user_rating    Double    사용자 평점
//     date    String    개봉일
//     id    String    영화 고유 ID
//     */
//    let audience: Int
//    let actor: String
//    let duration: Int
//    let director: String
//    let synopsis: String
//    let genre: String
//    let image: String
//
//    enum MovieDetailKey: String, CodingKey {
//        case audience, actor, duration, director, synopsis, genre, image
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MovieDetailKey.self)
//        audience = try container.decode(Int.self, forKey: .audience)
//        actor = try container.decode(String.self, forKey: .actor)
//        duration = try container.decode(Int.self, forKey: .duration)
//        director = try container.decode(String.self, forKey: .director)
//        synopsis = try container.decode(String.self, forKey: .synopsis)
//        genre = try container.decode(String.self, forKey: .genre)
//        image = try container.decode(String.self, forKey: .image)
//        try super.init(from: decoder)
//    }
//
//}

struct MovieDetail: Decodable {
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
    let id: String
    let title: String
    private let grade: MovieGrade.RawValue
    private let reservationGrade: Int
    let reservationRate: Double
    let userRating: Double
    let date: String
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let image: String
    
    var fullDescription: String {
        return "평점 : \(userRating) 예매순위 : \(grade) 예매율 : \(reservationRate)"
    }
    
    var shortDescription: String {
        return "\(grade)위\(userRating) / \(reservationRate)%"
    }
    
    var genreDescription: String {
        return "\(genre)/\(duration)분"
    }
    
    var gradeImage: UIImage {
        guard let image = MovieGrade(rawValue: grade)?.image else {
            return UIImage(named: "ic_0")!
        }
        return image
    }
    
    enum MovieGrade: Int {
        case all = 0
        case child = 12
        case youngth = 15
        case adult = 19
        
        var image: UIImage! {
            switch self {
            case .all:
                return UIImage(named: "ic_0")
            case .child:
                return UIImage(named: "ic_12")
            case .youngth:
                return UIImage(named: "ic_15")
            case .adult:
                return UIImage(named: "ic_19")
            }
        }
    }
    
    enum MovieKey: String, CodingKey {
        case id, grade, title, date, thumb
        case audience, actor, duration, director, synopsis, genre, image
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        
        id = try container.decode(String.self, forKey: .id)
        grade = try container.decode(Int.self, forKey: .grade)
        reservationGrade = try container.decode(Int.self, forKey: .reservationGrade)
        title = try container.decode(String.self, forKey: .title)
        reservationRate = try container.decode(Double.self, forKey: .reservationRate)
        userRating = try container.decode(Double.self, forKey: .userRating)
        date = try container.decode(String.self, forKey: .date)
        audience = try container.decode(Int.self, forKey: .audience)
        actor = try container.decode(String.self, forKey: .actor)
        duration = try container.decode(Int.self, forKey: .duration)
        director = try container.decode(String.self, forKey: .director)
        synopsis = try container.decode(String.self, forKey: .synopsis)
        genre = try container.decode(String.self, forKey: .genre)
        image = try container.decode(String.self, forKey: .image)
        
    }
    
}
