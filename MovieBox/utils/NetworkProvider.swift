//
//  NetworkProvider.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

final class NetworkProvider {
    static let baseURL = "https://connect-boxoffice.run.goorm.io/"
    static func request<DecodeType: Decodable>(url: URL, success: @escaping (DecodeType) -> Void, errorHandler: @escaping ()->Void) {
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, resource: URLResponse?, error: Error?) in
            if let error = error {
                errorHandler()
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let apiResponse: DecodeType = try JSONDecoder().decode(DecodeType.self, from: data)
                success(apiResponse)
            } catch(let error) {
                errorHandler()
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
