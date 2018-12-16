//
//  MovieDetailViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//
/*
 화면구성
 화면2 내비게이션 아이템 타이틀은 이전 화면에서 선택된 영화 제목입니다.
 영화 상세정보 화면을 구현합니다.
 영화 포스터를 포함한 소개, 줄거리, 감독/출연 그리고 한줄평을 모두 포함합니다.
 한줄평에는 작성자의 프로필, 닉네임, 별점, 작성일 그리고 평을 보여줍니다.
 기능
 영화 포스터를 터치하면 포스터를 전체화면에서 볼 수 있습니다.
 */

import UIKit
import Photos

class MovieDetailViewController: BaseViewController {

    //MARK: - Properties
    //MARK: IBOutlets
    @IBOutlet weak var detailTable: UITableView!
    
    //MARK: Private Properties
    private var detail: MovieDetail? = nil
    private var comments: [Comment] = []
    private var movieId: String = ""
    private let commentCellIdentifier: String = "comment_cell"
    private let headerCellIdentifier: String = "header_cell"
    private var isSizeChannged = true
    
    //MARK: - Methods
    //MARK: - Override Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullImage" {
            guard let navi = segue.destination as? UINavigationController else {return}
            guard let destination = navi.topViewController as? FullImageViewController else {return}
            guard let detail = detail else {return}
            guard let imageUrl = URL(string: detail.image) else {return}
            destination.bind(movieName: detail.title, url: imageUrl)
        }
    }
    
    //MARK: Data Binding
    func bindData(movie: Movie) {
        movieId = movie.id
        title = movie.title
    }
    
    //MARK: - Request Data
    func loadData() {
        toggleIndicator()
        let group = DispatchGroup()
        let queue = DispatchQueue.global()

        group.enter()
        queue.async(group: group) { [weak self] in
            guard let self = self else {return}
            MovieServiceImplement.service.getMovie(movieId: self.movieId, success: {[weak self] data in
                self?.detail = data
                group.leave()
            }, errorHandler: { [weak self] in
                    self?.errorHandler()
                    group.leave()
            })
        }
        
        group.enter()
        queue.async(group: group) { [weak self] in
            guard let self = self else {return}
            CommentServiceImplement.service.getComments(movieId: self.movieId, success: { [weak self] data in
                DispatchQueue.main.async {
                    self?.comments = data.comments
                    group.leave()
                }
            }, errorHandler: { [weak self] in
                    self?.errorHandler()
                    group.leave()
            })
        }
        
        group.notify(queue: queue) { [weak self] in
            DispatchQueue.main.async {
                self?.toggleIndicator()
                self?.detailTable.reloadData()
            }
        }
    }
}

//MARK: - Extensions
//MARK: TableView Delegate , DataSource
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let detail = detail else {return UITableViewCell()}
            guard let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier, for: indexPath) as? MovieHeaderTableViewCell else { return UITableViewCell() }
            cell.bindData(detail: detail)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
            cell.bindData(comment: comments[indexPath.row - 1])
            
            return cell
        }
    }
    
    
}
