//
//  MovieBoxDefaults.swift
//  MovieBox
//
//  Created by juhee on 11/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class MovieBoxDefaults {
    
    enum Sorting: Int {
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
        
        var type: Int {
            return self.rawValue
        }
    }
    
    private static let defaults = UserDefaults.standard
    private static let keySorting = "sortingBy"
    
    static let sortingArray : [Sorting] = [.booking, .curation, .openDate]
    
    //TODO: RECHECK
    private static var sortingType: Int = Sorting.booking.rawValue {
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
}
