//
//  Response.swift
//  MovieBox
//
//  Created by juhee on 14/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

struct ResponseMovies: Decodable {
    let movies: [Movie]
}
