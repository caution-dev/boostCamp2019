//
//  URL+Cache.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

extension URL {
    
    typealias ImageCacheCompletion = (UIImage) -> Void
    
    // 디스크 캐싱 경로 설정
    var diskPath: String {
        let diskPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cacheDirectory = diskPaths[0] as NSString
        let rtnPath = cacheDirectory.appendingPathComponent("\(self.absoluteString.hashValue)")
        return rtnPath
    }
    
    // 캐싱된 이미지가 있는지 체크
    private var cachedImage: UIImage? {
        if let image = ImageCache.shared.object(forKey: absoluteString as AnyObject) {
            return image as? UIImage
        } else {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: diskPath) {
                return UIImage(contentsOfFile: diskPath)
            }
        }
        return nil
    }
    
    //MARK: - Methods
    // 캐시 이미지 여부를 확인합니다.
    func fetchImage(completion: @escaping ImageCacheCompletion) {
        if let image = cachedImage {
            completion(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: self) {
            data, response, error in
            if error == nil {
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.setObject(
                        image,
                        forKey: self.absoluteString as AnyObject,
                        cost: data.count)
                    
                    let fileManager = FileManager.default
                    if fileManager.fileExists(atPath: self.diskPath) == false {
                        do {
                            try data.write(to: URL(fileURLWithPath: self.diskPath), options: .atomic)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
        task.resume()
    }
    
}
