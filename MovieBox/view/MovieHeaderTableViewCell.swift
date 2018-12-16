//
//  MovieHeaderTableViewCell.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class MovieHeaderTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var openDate: UILabel!
    @IBOutlet weak var reservationInfo: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    @IBOutlet weak var reservationRate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var audience: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actor: UILabel!
    @IBOutlet weak var starRating: StarRating!
    
    func bindData(detail data: MovieDetail) {
        movieTitle.text = data.title
        openDate.text = data.date + " 개봉"
        reservationInfo.text = data.genreDescription
        gradeImage.image = data.gradeImage
        reservationRate.text = data.shortDescription
        audience.text = data.audience.comaString
        starRating.rating = data.userRating
        rating.text = "\(data.userRating)"
        synopsis.text = """
        \(data.synopsis)
        """
        director.text = data.director
        actor.text = data.actor
        
        if let url = URL(string: data.image) {
            url.fetchImage { [weak self] image in
                self?.movieImage.image = image
            }
        }
    }
}
