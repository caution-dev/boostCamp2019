//
//  MovieTableViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

/*
 테이블 화면
 테이블뷰 셀에 영화 포스터를 보여줍니다.
 포스터 오른편에 영화정보(제목, 등급, 평점, 예매순위, 예매율, 개봉일)를 보여줍니다.
 화면 오른쪽 상단 바 버튼을 눌러 정렬방식을 변경할 수 있습니다. (예매율/큐레이션/개봉일 기준)
 테이블뷰와 컬렉션뷰의 영화 정렬방식은 동일하게 적용됩니다. 즉, 한 화면에서 변경하면 다른 화면에도 변경이 적용되어 있어야 합니다.
 테이블뷰와 컬렉션뷰를 아래쪽으로 잡아당기면 새로고침됩니다.
 테이블뷰/컬렉션뷰의 셀을 누르면 해당 영화의 상세 정보를 보여주는 화면 2로 전환합니다.
 */

import UIKit

class MovieTableViewController: UIViewController {
    //MARK :- Properties
    //MARK: IBOutlets
    @IBOutlet weak var movieTableView: UITableView!
    
    //MARK: Private Properties
    private let cellIdentifier: String = "movieTableViewCell"
    
    //MARK: Protocol Properties
    let refreshControl: UIRefreshControl? = UIRefreshControl()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    var netWorkErrorHandler: () -> Void = {}
    
    //MARK: - Methods
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let tintColor = UIColor.init(named: "Primary") ?? .blue
        initNetworkingIndicators(refreshTintColor: tintColor, activityTintColor: tintColor)
        movieTableView.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = MovieBoxDefaults.sorting.title
        loadData()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell =  sender as? UITableViewCell {
            if let indexPath = movieTableView.indexPath(for: cell) {
                guard let destination = segue.destination as? MovieDetailViewController else {
                    return
                }
                destination.bindData(movie: MovieInfoHolder.shared.item(at: indexPath.row))
            }
        }
    }
    
    //MARK: - Request Data
    private func loadData(force: Bool = false) {
        toggleIndicator()
        MovieInfoHolder.shared.getMovies(success: { [weak self] _ in
            DispatchQueue.main.async {
                self?.toggleIndicator(force: true)
                self?.refreshControl?.endRefreshing()
                self?.movieTableView.reloadData()
                self?.title = MovieBoxDefaults.sorting.title
            }
        }, errorHandler: self.netWorkErrorHandler, force: force)
    }
    
    @objc private func refreshData(_ sender: Any) {
        loadData(force: true)
    }
    
    //MARK: IBActions
    @IBAction func changeSortValue(_ sender: UIBarButtonItem) {
        sortChange { [weak self] in
            self?.loadData(force: true)
        }
    }
    
}

//MARK: - Extensions
//MARK: TableView Delegate , DataSource
extension MovieTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieInfoHolder.shared.noData ? 1 : MovieInfoHolder.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !MovieInfoHolder.shared.noData else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "데이터가 없습니다."
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(movie: MovieInfoHolder.shared.item(at: indexPath.row))
        return cell
    }

}

extension MovieTableViewController: SortChange, NetworkingIndicate {}
