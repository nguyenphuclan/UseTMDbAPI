//
//  Movie.swift
//  MovieApp
//
//  Created by Lan Nguyen on 5/21/17.
//  Copyright © 2017 Lan Nguyen. All rights reserved.
//

import Foundation
import UIKit

// Class Movie chứa thông tin phim dạng từ điển sau khi dùng API để lấy
class Movie {
    
    var id: Int?
    var title: String?
    var posterPath: String?
    var overview: String?
    
    init(view: [String:Any]) {
        id = view["id"] as? Int
        title = view["title"] as? String
        posterPath = view["poster_path"] as? String
        overview = view["overview"] as? String
    }
}
