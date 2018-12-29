//
//  BaseViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK :- Properties
    // table view 와 collection view 에 공통으로 사용할 refreshcontroller
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor.init(named: "Primary")
        return refresh
    }()
    // 네트워크 동작중에는 상태표시줄이나 화면에 인디케이터를 표시하세요.
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.hidesWhenStopped = true
        indicator.tintColor = UIColor.init(named: "Primary")
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return indicator
    }()
    // 네트워크 동작중 오류가 발생 시 사용자에게 알려주기
    lazy var errorHandler: () -> Void = { [weak self] in
       DispatchQueue.main.async {
            self?.showNetworkErrorAlert(completion: { [weak self] in
                self?.refreshControl.endRefreshing()
                self?.toggleIndicator(force: true)
            })
        }
    }

    //MARK :- Methods
    func toggleIndicator(force: Bool = false) {
        if force || activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    // 데이터 수신을 못하고 실패한 경우에는 알림창으로 사용자에게 안내하세요.
    func showNetworkErrorAlert(completion: (() -> Void)?, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: "서버 연결 불가", message: "데이터 수신에 실패했습니다. \n 잠시 후에 다시 시도해 주십시오.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "확인", style: .cancel, handler: actionHandler))
        present(alertVC, animated: true, completion: completion)
    }
    
    // 정렬 기준 변경
    func showChangeSortValue(completion: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "정렬 방식 선택", message: "영화를 어떤 방식으로 정렬할까요?", preferredStyle: .actionSheet)
        
        MovieBoxDefaults.Sorting.allCases.forEach { sorting in
            alertVC.addAction(UIAlertAction(title: sorting.title, style: .default, handler: { _ in
                MovieBoxDefaults.sorting = sorting
                completion()
            }))
        }
        
        alertVC.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
