//
//  MovieGrade.swift
//  MovieBox
//
//  Created by Wongeun Song on 2019. 1. 20..
//  Copyright © 2019년 juhee. All rights reserved.
//

import UIKit

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
