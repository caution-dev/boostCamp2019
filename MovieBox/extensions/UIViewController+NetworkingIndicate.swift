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
    
    func initNetworkingIndicators(refreshTintColor: UIColor, activityTintColor: UIColor) {
        refreshControl?.tintColor = refreshTintColor
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = refreshTintColor
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        netWorkErrorHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.showNetworkErrorAlert(completion: { [weak self] in
                    self?.refreshControl?.endRefreshing()
                    self?.toggleIndicator(force: true)
                })
            }
        }
    }
    
    func toggleIndicator(force turnOffActivityIndicatorForce: Bool = false) {
        if turnOffActivityIndicatorForce || activityIndicator.isAnimating {
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
