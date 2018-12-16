//
//  StarRating.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

@IBDesignable
class StarRating: UIStackView {
    
    //MARK: IBInspectable
    @IBInspectable var rating: Double = 7.98 {
        didSet {
            updateImageView()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 16.0, height: 16.0) {
        didSet {
            setupImageViews()
        }
    }
    //MARK: Private Properties
    private var ratingImageViews: [UIImageView] = []
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupImageViews()
    }

    //MARK: Private Methods
    private func setupImageViews() {
        guard let emptyStarImageView = UIImage(named: "ic_star_large") else {return}
        // clear any existing imageViews
        ratingImageViews.forEach { imageView in
            removeArrangedSubview(imageView)
            imageView.removeFromSuperview()
        }
        ratingImageViews.removeAll()
        
        for _ in 0..<5 {
            let imageView: UIImageView = UIImageView()
            imageView.image = emptyStarImageView
            
            // Add constraints
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            
            addArrangedSubview(imageView)
            ratingImageViews.append(imageView)
        }
    }
    
    private func updateImageView() {
        var calcRating: Double = rating
        let bundle = Bundle(for: type(of: self))
        let fullStar = UIImage(named: "ic_star_large_full", in: bundle, compatibleWith: self.traitCollection)
        let halfStar = UIImage(named: "ic_star_large_half", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "ic_star_large", in: bundle, compatibleWith: self.traitCollection)
        ratingImageViews.forEach { imageView in
            switch calcRating {
            case 2...:
                imageView.image = fullStar
            case 1..<2:
                imageView.image = halfStar
            default:
                imageView.image = emptyStar
            }
            calcRating -= 2
            if calcRating < 0 {
                return
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupImageViews()
        updateImageView()
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return CGSize(width: starSize.width * 5, height: starSize.height)
    }
}
