//
//  CommentService.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class CommentService {
    
    //MARK: - Properties
    static let service = CommentService()
    
    //MARK: - Methods
    func getComments(movieId: String, success: @escaping (ResponseComments) -> Void, errorHandler: @escaping () -> Void) {
        guard let url: URL = NetworkProvider.createURL(tailURL: "comments?movie_id=\(movieId)") else { return }
        NetworkProvider.request(url: url, success: success, errorHandler: errorHandler)
    }
}
