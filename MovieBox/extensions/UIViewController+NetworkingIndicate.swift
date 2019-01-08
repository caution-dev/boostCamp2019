//
//  UIVIewController+Network.swift
//  MovieBox
//
//  Created by juhee on 01/01/2019.
//  Copyright © 2019 juhee. All rights reserved.
//

import Foundation
import UIKit

extension NetworkingIndicate where Self: UIViewController {
    
    func toggleIndicator(force: Bool = false) {
        if force || activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    // 데이터 수신을 못하고 실패한 경우에는 알림창으로 사용자에게 안내하세요.
    func showNetworkErrorAlert(completion: (() -> Void)?, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = AlertManager.createAlertController(.networkError)()
        alertVC.addAction(UIAlertAction(title: "확인", style: .cancel, handler: actionHandler))
        present(alertVC, animated: true, completion: completion)
    }
}
