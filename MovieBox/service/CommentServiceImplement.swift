//
//  CommentServiceImplement.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class CommentServiceImplement {
    
    //MARK: - Properties
    static let service = CommentServiceImplement()
    
    //MARK: - Methods
    func getComments(movieId: String, success: @escaping (ResponseComments) -> Void, errorHandler: @escaping () -> Void) {
        guard let url: URL = URL(string: "\(NetworkProvider.baseURL)comments?movie_id=\(movieId)") else { return }
        NetworkProvider.request(url: url, success: success, errorHandler: errorHandler)
    }
}
