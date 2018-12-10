//
//  MovieCell.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 10.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }



}
