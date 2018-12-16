//
//  MovieServiceImplement.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class MovieService {

    //MARK: - Properties
    static let service = MovieService()
    
    //MARK: - Methods
    func getMovie(movieId: String, success: @escaping (MovieDetail) -> Void, errorHandler: @escaping () -> Void) {
        guard let url: URL = URL(string: "\(NetworkProvider.baseURL)movie?id=\(movieId)") else { return }
        NetworkProvider.request(url: url, model: MovieDetail.self, success: success, errorHandler: errorHandler)

    }
    
    func getMovies(success: @escaping (ResponseMovies) -> Void, errorHandler: @escaping () -> Void) {
        let orderType = MovieBoxDefaults.sorting.type
        guard let url: URL = URL(string: "\(NetworkProvider.baseURL)movies?order_type=\(orderType)") else { return }
        NetworkProvider.request(url: url, model: ResponseMovies.self, success: success, errorHandler: errorHandler)
    }
}
