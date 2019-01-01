//
//  AlertManager.swift
//  MovieBox
//
//  Created by juhee on 01/01/2019.
//  Copyright © 2019 juhee. All rights reserved.
//

import Foundation
import UIKit

enum AlertManager {
    case changeSorting
    case networkError
    
    var title: String? {
        switch self {
        case .changeSorting:
            return "정렬 방식 선택"
        case .networkError:
            return "서버 연결 불가"
        }
    }
    
    var message: String? {
        switch self {
        case .changeSorting:
            return "영화를 어떤 방식으로 정렬할까요?"
        case .networkError:
            return "데이터 수신에 실패했습니다. \n 잠시 후에 다시 시도해 주십시오."
        }
    }
    
    var alertStyle: UIAlertController.Style {
        switch self {
        case .changeSorting:
            return .actionSheet
        default:
            return .alert
        }
    }

    func createAlertController() -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: alertStyle)
    }
}
