//
//  MovieCollectionViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class MovieCollectionViewController: BaseViewController {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let cellAspectRatio: CGFloat = 1.8

    private let cellIdentifier: String = "movieCollectionViewCell"
    
    override func viewWillAppear(_ animated: Bool) {
        title = MovieBoxDefaults.sorting.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        toggleIndicator()
        loadData()
    }
    
    func loadData() {
        // 데이터가 없을 경우에만 API 호출한다.
        if Movie.data.isEmpty {
            MovieServiceImplement.service.getMovies { [weak self] movies in
                DispatchQueue.main.async {
                    self?.movieCollectionView.reloadData()
                }
            }
        } else {
            movieCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell =  sender as? UICollectionViewCell {
            if let indexPath = movieCollectionView.indexPath(for: cell) {
                guard let destination = segue.destination as? MovieDetailViewController else {
                    return
                }
                destination.bindData(movie: Movie.data[indexPath.row])
            }
        }
    }
}

extension MovieCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movie.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = Movie.data[indexPath.row]
        cell.title.text = movie.title
        cell.reservationInfo.text = movie.shortDescription
        cell.openDate.text = movie.date
        cell.grade.image = movie.gradeImage
        cell.thumb.image = nil
        cell.imageUrl = movie.thumbUrl
        
        //TODO: 이미지 처리 별도 함수로 빼기
        DispatchQueue.global().async {
            guard let url = movie.thumbUrl else {return}
            guard let imageData: Data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
//                if cell == collectionView.cellForItem(at: indexPath) {
//                    cell.thumb.image = UIImage(data: imageData)
//                }
                if cell.imageUrl == url {
                    cell.thumb.image = UIImage(data: imageData)
                } else {
                    print("this is recycle")
                }
            }
        }
        return cell
    }
    
    // Cell 너비 높이 지정
    // Cell width = half of CollectionView width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let availableWidth = collectionView.frame.width
        let widthPerItem = availableWidth / itemsPerRow
        let height = widthPerItem * cellAspectRatio

        return CGSize(width: widthPerItem, height: height)
    }
}
