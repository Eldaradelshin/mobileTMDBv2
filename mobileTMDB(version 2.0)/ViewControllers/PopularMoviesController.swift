//
//  PopularMoviesController.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class PopularMoviesController: UITableViewController {
    
    let dateService = DateService()
    
    let requestClient = TMDBRequestClient()
    
    var movies: [Movie] = []
    private var currentPage = 1
    private var shouldShowLoadingCell = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новые фильмы"
        
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PopularMoviesCell.self, forCellReuseIdentifier: String(describing: PopularMoviesCell.self))
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        
        refreshControl?.beginRefreshing()
        loadMovies()
        
        
    }

    @objc
    private func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    private func loadMovies(refresh: Bool = false) {
        
        print("Fetching page \(currentPage)")
        requestClient.fetchNewMovies(
            page: currentPage,
            startReleaseDate: dateService.getFormattedDate(date: dateService.currentDateWeekEarlier),
            endReleaseDate: dateService.getFormattedDate(date: dateService.currentDateWeekLater)) { response in
                
            DispatchQueue.main.async {
                
                if refresh {
                    self.movies = response.results
                } else {
                    for movie in response.results {
                        if !self.movies.contains(movie) {
                            self.movies.append(movie)
                        }
                    }
                }
                
                self.shouldShowLoadingCell = response.page < response.total_pages
                
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchNextPage() {
        currentPage += 1
        loadMovies()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = movies.count
        return shouldShowLoadingCell ? count + 1 : count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isLoadingIndexPath(indexPath) {
            return LoadingCell(style: .default, reuseIdentifier: "loading")
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
            let movie = movies[indexPath.row]
            let genresString = GenresRuDict.genresString(inputGenres: movie.genre_ids)
            
            cell.movieTitle.text = movie.title
            cell.movieGenres.text = genresString
            
            return cell
            
        }

    }
 
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchNextPage()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == self.movies.count
    }
}
