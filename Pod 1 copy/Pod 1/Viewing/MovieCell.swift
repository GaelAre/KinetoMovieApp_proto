//
//  MovieCell.swift
//  Pod 1
//
//  Created by sunqiao lin on 4/17/23.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {

    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var MovieOverview: UILabel!
    
    func configure(with movie: Movie){
        MovieTitle.text = movie.original_title
        MovieOverview.text = movie.overview
        
        Nuke.loadImage(with: URL(string:"https://image.tmdb.org/t/p/w500" + movie.poster_path.absoluteString)!, into: movieImage)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
