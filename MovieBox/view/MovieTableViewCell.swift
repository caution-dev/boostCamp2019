//
//  MovieTableViewCell.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var grade: UIImageView!
    @IBOutlet weak var fullDescription: UILabel!
    @IBOutlet weak var openDate: UILabel!
    var imageUrl: URL?
    
    func bindData(movie data: Movie) {
        title.text = data.title
        fullDescription.text = data.fullDescription
        grade.image = data.gradeImage
        openDate.text = data.date
        thumb.image = nil
        imageUrl = data.thumbUrl
        
        if let thumbUrl = data.thumbUrl {
            thumbUrl.fetchImage { [weak self] image in
                if self?.imageUrl == thumbUrl {
                   self?.thumb.image = image
                }
            }
        }
    }
}
