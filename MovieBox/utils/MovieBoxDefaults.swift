//
//  MovieBoxDefaults.swift
//  MovieBox
//
//  Created by juhee on 11/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class MovieBoxDefaults {
    
    private static let defaults = UserDefaults.standard
    private static let keySorting = "sortingBy"
    
    // UserDefault 에 정렬 기준 저장
    private static var sortingType: Int = defaults.integer(forKey: keySorting) {
        willSet(newValue) {
            defaults.set(newValue, forKey: keySorting)
        }
    }
    
    static var sorting: Sorting {
        get {
            return Sorting(rawValue: sortingType) ?? Sorting.booking
        }
        set {
            sortingType = newValue.rawValue
        }
    }
    
    // 정렬 기준에 대한 정보 표시
    enum Sorting: Int, CaseIterable {
        case booking = 0
        case curation = 1
        case openDate = 2
        
        var title: String {
            switch self {
            case .booking:
                return "예매율"
            case .curation:
                return "큐레이션"
            case .openDate:
                return "개봉일"
            }
        }
        
        // rawValue 를 넘겨준다. 좀 더 접근하기 쉽도록 만든 property
        var type: Int {
            return self.rawValue
        }
    }
}
