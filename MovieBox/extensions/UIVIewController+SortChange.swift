//
//  UIViewController+SortChange.swift
//  MovieBox
//
//  Created by juhee on 01/01/2019.
//  Copyright © 2019 juhee. All rights reserved.
//

import UIKit

extension SortChange where Self: UIViewController {
    func sortChange(completion: @escaping () -> Void) {
        let alertVC = AlertManager.changeSorting.createAlertController()
        
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
