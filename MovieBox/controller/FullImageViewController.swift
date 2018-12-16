//
//  FullImageViewController.swift
//  MovieBox
//
//  Created by juhee on 16/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit
import Photos

class FullImageViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: IBOutlets
    @IBOutlet weak var fullImage: UIImageView!
    
    //MARK: Private Properties
    private var imageUrl: URL!
    
    //MARK: - Methods
    //MARK: - Override Methods
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageUrl.fetchImage { [weak self] image in
            self?.fullImage.image = image
        }
    }
    
    //MARK: Data Binding 
    func bind(movieName: String, url: URL) {
        title = movieName
        imageUrl = url
    }
    
    //MARK: IBActions
    @IBAction func dismissViewController(sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extensions
//MARK: UIScrollViewDelegate
extension FullImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return fullImage
    }
}
