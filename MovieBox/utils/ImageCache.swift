//
//  ImageCache.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import Foundation

class ImageCache {
    static let shared: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "ImageCache"
        cache.countLimit = 20
        cache.totalCostLimit = 10*1024*1024
        return cache
    }()
}
