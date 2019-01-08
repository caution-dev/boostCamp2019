//
//  MovieCollectionViewController.swift
//  MovieBox
//
//  Created by juhee on 13/12/2018.
//  Copyright © 2018 juhee. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController {
    //MARK :- Properties
    //MARK: IBOutlet
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    //MARK: Private Properties
    private let itemsPerRow: CGFloat = 2
    private let cellAspectRatio: CGFloat = 1.8
    private let cellIdentifier: String = "movieCollectionViewCell"
    private let noDataCellIdentifier: String = "no_data_cell"
    
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
        movieCollectionView.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = MovieBoxDefaults.sorting.title
        loadData()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell =  sender as? UICollectionViewCell {
            if let indexPath = movieCollectionView.indexPath(for: cell) {
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
        MovieInfoHolder.shared.getMovies(success: { [weak self] movies in
            DispatchQueue.main.async {
                self?.toggleIndicator()
                self?.movieCollectionView.reloadData()
                self?.title = MovieBoxDefaults.sorting.title
                self?.refreshControl?.endRefreshing()
            }
        }, errorHandler: self.netWorkErrorHandler, force: force)
    }
    
    @objc func refreshData(_ sender: Any) {
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
//MARK: CollectionView Delegate , DataSource
extension MovieCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieInfoHolder.shared.noData ? 1 : MovieInfoHolder.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !MovieInfoHolder.shared.noData else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noDataCellIdentifier, for: indexPath)
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bindData(movie: MovieInfoHolder.shared.item(at: indexPath.item))
        return cell
    }
    
    // Cell width = half of CollectionView width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let availableWidth = collectionView.frame.width
        let widthPerItem = availableWidth / itemsPerRow
        let height = widthPerItem * cellAspectRatio

        return CGSize(width: widthPerItem, height: height)
    }
}

extension MovieCollectionViewController: SortChange, NetworkingIndicate {}
