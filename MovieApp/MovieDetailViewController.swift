//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Lan Nguyen on 5/21/17.
//  Copyright © 2017 Lan Nguyen. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    var idMovie: Int?
    var posterPath: String?
    let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetail()
        queue.addOperation { () -> Void in
            // nếu image tải về khác nil thì gán vào image
            if let image = Downloader.downloadImageWithURL("\(prefixImage)w185\(self.posterPath ?? "nill")") {
                OperationQueue.main.addOperation({
                    self.posterImage.image = image
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovieDetail() {
        // Nếu id của movie khác nil thì gán cho movieId
        if let movieId = idMovie {
            let url = NSURL(string: "\(prefixMovie)\(movieId)?\(key)&\(language)")
            var detail = [String:Any]()
            let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
            request.httpMethod = "GET"
            _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
                if (Error != nil) {
                    print(Error!)
                } else {
                    do {
                        detail = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                        DispatchQueue.main.async {
                            // Lấy thông tin mà mình cần từ kết quả trả về sau khi dùng API
                            if let title = detail["title"] {
                                self.titleLabel.text = title as? String
                            }
                            if let overview = detail["overview"] {
                                self.overviewLabel.text = overview as? String
                            }
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }).resume()
        }
    }
}
