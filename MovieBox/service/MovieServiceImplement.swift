//
//  MovieServiceImplement.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class MovieServiceImplement : MovieService {

    private let baseUrl = "http://connect-boxoffice.run.goorm.io/"
    static let service = MovieServiceImplement()
    
    func getMovie(movieId: String, handler: @escaping (MovieDetail) -> Void) {
        guard let url: URL = URL(string: "\(baseUrl)movie?id=\(movieId)") else {return}
    
        // TODO: 중복 코드 묶기
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, resource: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let apiResponse: MovieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                handler(apiResponse)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func getMovies(handler: @escaping ([Movie]) -> Void) {
        let orderType = MovieBoxDefaults.sorting.type
        
        guard let url: URL = URL(string: "\(baseUrl)movies?order_type=\(orderType)") else {return}
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, resource: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let apiResponse: ResponseMovies = try JSONDecoder().decode(ResponseMovies.self, from: data)
                Movie.data = apiResponse.movies
                handler(apiResponse.movies)
                
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
