//
//  MoviesTableViewController.swift
//  MovieApp
//
//  Created by Lan Nguyen on 5/21/17.
//  Copyright © 2017 Lan Nguyen. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var movies = [Movie]()
    var page = 1
    let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Khai báo 1 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        // Hình mặc định khi ko load được ảnh
        cell.posterImage.image = #imageLiteral(resourceName: "default")

        //Thêm 1 operation vào queue
        queue.addOperation { () -> Void in
            // Dùng Dowloader để tải hình về
            let url = "\(prefixImage)w185\(self.movies[indexPath.row].posterPath ?? "nil")"
            if let img = Downloader.downloadImageWithURL(url) {
                OperationQueue.main.addOperation({
                    cell.posterImage.image = img
                })
            }
        }
        
        cell.titleLabel.text = movies[indexPath.row].title
        cell.overviewLabel.text = movies[indexPath.row].overview

        return cell
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let movieDetail = segue.destination as! MovieDetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // Lấy id và đường dẫn từ movie để lấy dữ liệu detail movie tương ứng
                movieDetail.idMovie = movies[indexPath.row].id!
                movieDetail.posterPath = movies[indexPath.row].posterPath!
            }
        }
    }
    
    // Load dữ liệu movie sau khi dùng API
    func loadData(){
        //Tăng dần số page để lấy thông tin movie theo page
        TMDb.getMovieList(inPage: page) { (list, error) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.movies.append(contentsOf: list)
                    self.tableView.reloadData()
                }
            }
        }
        page += 1
    }
}
