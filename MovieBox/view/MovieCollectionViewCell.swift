//
//  MovieCollectionViewswift
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
    
    func bindData(movie data: Movie) {
        title.text = data.title
        reservationInfo.text = data.shortDescription
        openDate.text = data.date
        grade.image = data.gradeImage
        thumb.image = nil
        imageUrl = data.thumbUrl
        
        if let thumbUrl = data.thumbUrl {
            thumbUrl.fetchImage { [weak self] image in
                // Check the cell hasn't recycled while loading.
                if self?.imageUrl == thumbUrl {
                    self?.thumb.image = image
                }
            }
        }
    }
}
