//
//  CommentService.swift
//  MovieBox
//
//  Created by juhee on 15/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

protocol CommentService {
    func getComments(movieId: String, success: @escaping (ResponseComments)->Void, errorHandler: @escaping ()->Void)
}
