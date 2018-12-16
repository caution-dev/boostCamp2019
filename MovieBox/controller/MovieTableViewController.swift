//
//  MovieTableViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class MovieTableViewController: BaseViewController {
    /*
     테이블 화면
     테이블뷰 셀에 영화 포스터를 보여줍니다.
     포스터 오른편에 영화정보(제목, 등급, 평점, 예매순위, 예매율, 개봉일)를 보여줍니다.
     화면 오른쪽 상단 바 버튼을 눌러 정렬방식을 변경할 수 있습니다. (예매율/큐레이션/개봉일 기준)
     테이블뷰와 컬렉션뷰의 영화 정렬방식은 동일하게 적용됩니다. 즉, 한 화면에서 변경하면 다른 화면에도 변경이 적용되어 있어야 합니다.
     테이블뷰와 컬렉션뷰를 아래쪽으로 잡아당기면 새로고침됩니다.
     테이블뷰/컬렉션뷰의 셀을 누르면 해당 영화의 상세 정보를 보여주는 화면 2로 전환합니다.
     */
    
    @IBOutlet weak var movieTableView: UITableView!
    
    private let cellIdentifier: String = "movieTableViewCell"
    
    override func viewDidAppear(_ animated: Bool) {
        toggleIndicator()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = MovieBoxDefaults.sorting.title
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell =  sender as? UITableViewCell {
            if let indexPath = movieTableView.indexPath(for: cell) {
                guard let destination = segue.destination as? MovieDetailViewController else {
                    return
                }
                destination.bindData(movie: Movie.data[indexPath.row])
            }
        }
    }
    
    func loadData() {
        // 데이터가 없을 경우에만 API 호출한다.
        if Movie.data.isEmpty {
            MovieServiceImplement.service.getMovies { [weak self] movies in
                DispatchQueue.main.async {
                    self?.movieTableView.reloadData()
                }
            }
        } else {
            movieTableView.reloadData()
        }
    }

}

extension MovieTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = Movie.data[indexPath.row]
        cell.title.text = movie.title
        cell.fullDescription.text = movie.fullDescription
        cell.grade.image = movie.gradeImage
        cell.thumb.image = nil
        
        //TODO: 이미지 처리 별도 함수로 빼기
        DispatchQueue.global().async {
            guard let url = movie.thumbUrl else {return}
            guard let imageData: Data = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.thumb.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }

}
