//
//  CommentTableViewCell.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var rating: StarRating!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var contents: UILabel!
    
    func bindData(comment data: Comment) {
        timestamp.text = data.getTimestmap()
        contents.text = data.contents
        rating.rating = data.rating
        writer.text = data.writer
    }
}
