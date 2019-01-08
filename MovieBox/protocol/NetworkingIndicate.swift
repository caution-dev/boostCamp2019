//
//  NetworkingIndicate.swift
//  MovieBox
//
//  Created by juhee on 01/01/2019.
//  Copyright © 2019 juhee. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkingIndicate: class {
    var refreshControl: UIRefreshControl? { get }
    var activityIndicator: UIActivityIndicatorView { get }
    var netWorkErrorHandler: () -> Void { get set }
}
