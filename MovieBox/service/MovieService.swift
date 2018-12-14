//
//  MovieService.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

func getMovies(handler: @escaping ([Movie]) -> Void) {
    
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=1") else {return}
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, resource: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {return}
        
        do {
            let apiResponse: ResponseMovies = try JSONDecoder().decode(ResponseMovies.self, from: data)
            handler(apiResponse.movies)

        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    dataTask.resume()
}

func getMovieDetail() -> Movie? {
    return nil
}
