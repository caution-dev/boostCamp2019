//
//  MovieService.swift
//  MovieBox
//
//  Created by juhee on 15/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

protocol MovieService {
    func getMovies(success: @escaping (ResponseMovies)->Void, errorHandler: @escaping ()->Void)
    func getMovie(movieId: String, success: @escaping (MovieDetail)->Void, errorHandler: @escaping ()->Void)
}
