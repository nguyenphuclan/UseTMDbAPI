//
//  Downloader.swift
//  MovieApp
//
//  Created by Lan Nguyen on 5/22/17.
//  Copyright © 2017 Lan Nguyen. All rights reserved.
//

import Foundation
import UIKit

// Lớp dùng để tải hình ảnh từ URL chỉ định
class Downloader {
    
    class func downloadImageWithURL(_ url:String?) -> UIImage? {
        let data : Data
        do {
            data = try Data(contentsOf: URL(string: url!)!)
            return UIImage(data: (data))
        } catch {
            return nil
        }
    }
}
