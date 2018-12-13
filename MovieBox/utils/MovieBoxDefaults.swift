//
//  MovieBoxDefaults.swift
//  MovieBox
//
//  Created by juhee on 11/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class MovieBoxDefaults {
    
    enum Sorting: String {
        case booking
        case curation
        case openDate
        
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
    }
    
    private static let defaults = UserDefaults.standard
    private static let keySorting = "sortingBy"
    static let sortingArray : [Sorting] = [.booking, .curation, .openDate]
    
    static var sortedValue: String = Sorting.booking.rawValue {
        willSet(newValue) {
            defaults.set(newValue, forKey: keySorting)
        }
    }
}
