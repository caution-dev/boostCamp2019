//
//  MovieDetail.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetail: Codable {
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
    private let grade: Int
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
    
    enum CodingKeys: String, CodingKey {
        case id, grade, title, date, audience, actor, duration, director, synopsis, genre, image
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
    
    var shortDescription: String {
        return "\(reservationGrade)위 / \(reservationRate)%"
    }
    
    var genreDescription: String {
        return "\(genre) / \(duration)분"
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
    
}
