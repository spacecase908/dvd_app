//
//  TableViewCell.swift
//  AngryBirds
//
//  Created by user194382 on 4/5/21.
//

import UIKit

class BirdCell: UITableViewCell {
    @IBOutlet weak var BirdNameLabel: UILabel!
    
    @IBOutlet weak var BirdDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
