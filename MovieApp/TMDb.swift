//
//  TMDb.swift
//  MovieApp
//
//  Created by Lan Nguyen on 5/21/17.
//  Copyright © 2017 Lan Nguyen. All rights reserved.
//

import Foundation

class TMDb {
    
    // Lấy API get now playing của TMDb để hiễn thị cho phần Movie List
    static func getMovieList(inPage page: Int, completionHandler: @escaping (_ data: [Movie], Error?) -> Void ) {
        var view = [String:Any]()
        var listMovie = [Any]()
        let url = NSURL(string: "\(prefixMovie)now_playing?\(key)&\(language)&page=\(page)")
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
        
        request.httpMethod = "GET"
        print("start request page \(page)")
        _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, urlResponse, error) in
            print("request compelete")
            if (error != nil) {
                completionHandler([], error)
                print(error!)
            } else {
                do {
                    view = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    // lấy kết quả trả về, results là 1 mảng
                    listMovie = view["results"] as! [Any]
                    var movies = [Movie]()
                    // Mỗi movie trong mảng listMovie lấy từ results ta sẽ thêm vào class Movie
                    // Mỗi movie là 1 từ điển chứa thông tin phim, vd title:String , overview:String  ...,
                    for movie in listMovie {
                        movies.append(Movie(view: movie as! [String:Any]))
                    }
                    completionHandler(movies, error)
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
}
