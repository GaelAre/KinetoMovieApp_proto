//
//  ThreaterCell.swift
//  Pod 1
//
//  Created by sunqiao lin on 4/25/23.
//

import UIKit

class ThreaterCell: UITableViewCell {

    @IBOutlet weak var threaterLocation: UILabel!
    @IBOutlet weak var threaterName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with track:Track){
            
            threaterName.text = track.name
            threaterLocation.text = track.address
        }

}
