//
//  PopularMoviesController.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit
import Nuke.Swift


class PopularMoviesController: UITableViewController {
    let preheater = Nuke.ImagePreheater()
    let dateService = DateService()
    
    let requestClient = TMDBRequestClient()
    
    var totalMovieCount: Int = 0
    var movies: [Movie] = []
    private var currentPage = 1
    private var isFetchingNextPage = false
    private var shouldShowLoadingCell = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новые фильмы"
        
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        
        refreshControl?.beginRefreshing()
        loadMovies(refresh: true)
        
        
    }

    @objc
    private func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    private func loadMovies(refresh: Bool = false) {
        print("Fetching page \(self.currentPage)")
        isFetchingNextPage = true
        let startData4Request = dateService.getFormattedDate(date: dateService.currentDateWeekEarlier)
        let endData4Request = dateService.getFormattedDate(date: dateService.currentDateWeekLater)
        
        requestClient.fetchNewMovies(page: self.currentPage, startReleaseDate: startData4Request, endReleaseDate: endData4Request) { dataResponse in
            DispatchQueue.main.async {
                self.totalMovieCount = dataResponse.total_results
                if refresh == true {
                    self.movies = dataResponse.results
                } else if refresh == false {
                    
                    for movie in dataResponse.results {
                        if self.movies.contains(movie) == false {
                            self.movies.append(movie)
                        }
                    }
                }
                self.isFetchingNextPage = false
                
                if refresh {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                } else {
                
                    let startIndex = self.movies.count - dataResponse.results.count
                    let endIndex = startIndex + dataResponse.results.count - 1
                    let newIndexPaths = (startIndex...endIndex).map { i in
                        return IndexPath(row: i, section: 0)
                }
                let visibleIndexPaths = Set(self.tableView.indexPathsForVisibleRows ?? [])
                let indexPathNeedingReload = Set(newIndexPaths).intersection(visibleIndexPaths)
                self.tableView.reloadRows(at: Array(indexPathNeedingReload), with: .fade)
                }
                
            }
        }
    }
    
    private func fetchNextPage() {
        guard !isFetchingNextPage else { return }
        self.currentPage += 1
        loadMovies(refresh: false)
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return totalMovieCount
    }

    func imageUrl(for movie: Movie) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(movie.poster_path ?? "")")!
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isLoadingIndexPath(indexPath) {
            return LoadingCell(style: .default, reuseIdentifier: "loading")
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
            let movie = movies[indexPath.row]
            
            let url = imageUrl(for: movie)
            Nuke.loadImage(with: url, into: cell.moviePoster)
            let genresString = GenresRuDict.genresString(inputGenres: movie.genre_ids)
            
            cell.movieTitle.text = movie.title
            cell.movieGenres.text = genresString
            
            return cell
            
        }

    }
 
    
    // MARK: UITableViewDelegate
   
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.movies.count
    }
}

extension PopularMoviesController: UITableViewDataSourcePrefetching {
    
    func imageRequests(indexPaths: [IndexPath]) -> [Nuke.ImageRequest]{
        let movies: [Movie] = indexPaths.compactMap { indexPath in
            guard indexPath.row < self.movies.count else { return nil }
            return self.movies[indexPath.row]
        }
        let imageUrls = movies.map(self.imageUrl)
        let requests = imageUrls.map(Nuke.ImageRequest.init)
        return requests
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //print("Prefetch rows at: \(indexPaths)")
        
        let requests = imageRequests(indexPaths: indexPaths)
        preheater.startPreheating(with: requests)
        
        let needsFetch = indexPaths.contains { $0.row >= self.movies.count }
        if needsFetch {
            fetchNextPage()
        }

    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //print("Cancel prefetch for: \(indexPaths)")
        
        let requests = imageRequests(indexPaths: indexPaths)
        preheater.stopPreheating(with: requests)
    }
}
