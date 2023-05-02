//
//  DetailViewController.swift
//  Pod 1
//
//  Created by Naomi Wu on 4/24/23.
//

import Foundation
import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var trackNameLabel: UILabel!

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    var track: Track!
    var time: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        trackNameLabel.text = track.name
        artistLabel.text = track.distance
        albumLabel.text = track.address
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let today = dateFormatter.string(from: Date())
        genreLabel.text = today
        
        let timesText = time?.prefix(7).joined(separator: "\n")
        releaseDateLabel.text = timesText
    }
}
