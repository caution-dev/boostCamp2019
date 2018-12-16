//
//  BinaryInteger+NumberFormatter.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

extension Formatter {
    static let comaSeperator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var comaString: String {
        return Formatter.comaSeperator.string(for: self) ?? ""
    }
}

