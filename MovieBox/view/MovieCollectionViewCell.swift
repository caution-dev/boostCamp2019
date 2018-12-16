//
//  MovieCollectionViewCell.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var reservationInfo: UILabel!
    @IBOutlet weak var openDate: UILabel!
    @IBOutlet weak var grade: UIImageView!
    var imageUrl: URL?
    
}
