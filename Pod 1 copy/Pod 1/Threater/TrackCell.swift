//
//  TrackCell.swift
//  Pod 1
//
//  Created by Naomi Wu on 4/24/23.
//

import UIKit
import Nuke

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Configures the cell's UI for the given track.
    func configure(with track: Track) {
        trackNameLabel.text = track.name
        artistNameLabel.text = track.address

        // Load image async via Nuke library image loading helper method
//        Nuke.loadImage(with: track.artworkUrl100, into: trackImageView)
    }
    
    

}
