//
//  BaseViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
//    네트워크 동작중에는 상태표시줄이나 화면에 인디케이터를 표시하세요.
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    open var update: () -> () = {}

    func toggleIndicator () {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
    }

    @IBAction func changeSortValue(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController(title: "정렬 방식 선택", message: "영화를 어떤 방식으로 정렬할까요?", preferredStyle: .actionSheet)
        
        MovieBoxDefaults.sortingArray.forEach { sorting in
            alertVC.addAction(UIAlertAction(title: sorting.title, style: .default, handler: { _ in
                MovieBoxDefaults.sortedValue = sorting.rawValue
            }))
        }
        
        alertVC.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
//  데이터 수신을 못하고 실패한 경우에는 알림창으로 사용자에게 안내하세요.
    func showNetworkErrorAlert() {
        let alertVC = UIAlertController(title: "서버 연결 불가", message: "데이터 수신에 실패했습니다. 잠시 후에 다시 시도해 주십시오.", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
