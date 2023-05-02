//
//  ViewController.swift
//  Pod 1
//
//  Created by sunqiao lin on 4/17/23.
//

import UIKit
import Nuke
class DetailViewController1: UIViewController {
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieVote: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie:Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Nuke.loadImage(with: URL(string:"https://image.tmdb.org/t/p/w500" + movie.poster_path.absoluteString)!, into: movieImageView)
        
        movieName.text = movie.original_title
        movieVote.text = String(movie.vote_count) + " Votes"
        moviePopularity.text = String(movie.popularity) + " Popularity"
        movieOverview.text = movie.overview
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation
​
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
