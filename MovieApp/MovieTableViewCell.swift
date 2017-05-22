//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Lan Nguyen on 5/21/17.
//  Copyright © 2017 Lan Nguyen. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
