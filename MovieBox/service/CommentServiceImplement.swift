//
//  CommentServiceImplement.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class CommentServiceImplement : CommentService {
    
    //MARK: - Properties
    private let baseUrl = "http://connect-boxoffice.run.goorm.io/comments"
    static let service = CommentServiceImplement()
    
    //MARK: - Methods
    func getComments(movieId: String, success: @escaping (ResponseComments) -> Void, errorHandler: @escaping () -> Void) {
        guard let url: URL = URL(string: "\(baseUrl)?movie_id=\(movieId)") else { return }
        NetworkProvider.request(url: url, model: ResponseComments.self, success: success, errorHandler: errorHandler)
    }
}
