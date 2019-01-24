//
//  Movie.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

struct Movie: Codable {
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
    let title: String
    private let thumb: String?
    private let grade: Int
    private let reservationGrade: Int
    let reservationRate: Double
    private let userRating: Double
    let date: String
    
    var fullDescription: String {

        return "평점 : \(userRating) 예매순위 : \(reservationGrade) 예매율 : \(reservationRate)"
    }
    
    var shortDescription: String {
        return "\(reservationGrade)위 (\(userRating)) / \(reservationRate)%"
    }
    
    var gradeImage: UIImage {
        guard let image = MovieGrade(rawValue: grade)?.image else {
            return UIImage(named: "ic_0")!
        }
        return image
    }
    
    var thumbUrl: URL? {
        guard let thumbnail = thumb else {return nil}
        guard let imageURL: URL = URL(string: thumbnail) else  {return nil}
        return imageURL
    }
    
    enum CodingKeys: String, CodingKey {
        case id, grade, title, date, thumb
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
}
