//
//  MovieService.swift
//  MovieBox
//
//  Created by juhee on 15/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

protocol MovieService {
    func getMovies(handler: @escaping ([Movie])->Void)
    func getMovie(movieId: String, handler: @escaping (MovieDetail)->Void)
}
