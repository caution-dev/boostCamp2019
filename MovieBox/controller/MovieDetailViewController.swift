//
//  MovieDetailViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    /*
     화면구성
     화면2 내비게이션 아이템 타이틀은 이전 화면에서 선택된 영화 제목입니다.
     영화 상세정보 화면을 구현합니다.
     영화 포스터를 포함한 소개, 줄거리, 감독/출연 그리고 한줄평을 모두 포함합니다.
     한줄평에는 작성자의 프로필, 닉네임, 별점, 작성일 그리고 평을 보여줍니다.
     기능
     영화 포스터를 터치하면 포스터를 전체화면에서 볼 수 있습니다.
     */
    
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
    @IBOutlet weak var commentsTable: UITableView!
    
    private var comments: [Comment] = []
    private var movieId: String = ""
    private let reusableIdentifier: String = "comment_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetail()
        
        //TODO: HeaderView Binding
    }

    func bindData(movie: Movie) {
        movieId = movie.id
        title = movie.title
    }
    
    func getMovieDetail() {
        MovieServiceImplement.service.getMovie(movieId: movieId) { [weak self] detail in
            DispatchQueue.main.async {
                self?.setHeadderView(data: detail)
            }
        }
        CommentServiceImplement.service.getComments(movieId: movieId, success: { [weak self] comments in
            DispatchQueue.main.async {
                self?.comments = comments
                self?.commentsTable.reloadData()
            }
        }, error: { [weak self] in
                self?.showNetworkErrorAlert()
        })
    }
    
    private func setHeadderView(data: MovieDetail) {
        movieTitle.text = data.title
        openDate.text = data.date + " 개봉"
        reservationInfo.text = data.genreDescription
        gradeImage.image = data.gradeImage
        reservationRate.text = "\(data.reservationRate)"
        audience.text = data.audience.comaString
        starRating.rating = data.userRating
        rating.text = "\(data.userRating)"
        synopsis.text = """
                        \(data.synopsis)
                        """
        director.text = data.director
        actor.text = data.actor
        
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: data.image) else {return}
            guard let imageData: Data = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                self?.movieImage.image = UIImage(data: imageData)
            }
        }
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        let comment = comments[indexPath.row]
        cell.timestamp.text = comment.getTimestmap()
        cell.contents.text = comment.contents
        cell.rating.rating = comment.rating
        cell.writer.text = comment.writer
        
        return cell
    }
    
    
}
