//
//  TableViewCell.swift
//  AngryBirds
//
//  Created by user194382 on 4/5/21.
//

import UIKit

class FilmCell: UITableViewCell {
    
    
    @IBOutlet weak var FilmDescriptionLabel: UILabel!
    @IBOutlet weak var FilmNameLabel: UILabel!
    @IBOutlet weak var FilmImageView: UIImageView!
    
    
    var film: Film? {
        didSet {
            self.FilmNameLabel.text = film?.name
            self.FilmDescriptionLabel.text = film?.description
            self.FilmDescriptionLabel.lineBreakMode = .byTruncatingTail
            
            self.accessoryType = film!.watched ? .checkmark : .none
            
            DispatchQueue.global(qos: .userInitiated).async {
                let filmImageData = NSData(contentsOf: URL(string: self.film!.imageUrl)!)
                DispatchQueue.main.async {
                    self.FilmImageView.image = UIImage(data: filmImageData! as Data)
                    self.FilmImageView.layer.cornerRadius = self.FilmImageView.frame.width/2
                }
            }
        }
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
