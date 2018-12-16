//
//  CommentServiceImplement.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class CommentServiceImplement : CommentService {
    
    private let baseUrl = "http://connect-boxoffice.run.goorm.io/comments"
    static let service = CommentServiceImplement()
    
    func getComments(movieId: String, success: @escaping ([Comment]) -> Void, error: @escaping () -> Void) {
        guard let url: URL = URL(string: "\(baseUrl)?movie_id=\(movieId)") else {return}
        
        // TODO: 중복 코드 묶기
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, resource: URLResponse?, err: Error?) in
        
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            do {
                let apiResponse: ResponseComments = try JSONDecoder().decode(ResponseComments.self, from: data)
                success(apiResponse.comments)
                
            } catch(let err) {
                error()
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
