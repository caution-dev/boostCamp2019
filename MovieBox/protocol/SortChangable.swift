//
//  SortChangable.swift
//  MovieBox
//
//  Created by juhee on 01/01/2019.
//  Copyright © 2019 juhee. All rights reserved.
//

import Foundation
import UIKit

protocol SortChange: class {
    func sortChange(completion: @escaping () -> Void)
}
