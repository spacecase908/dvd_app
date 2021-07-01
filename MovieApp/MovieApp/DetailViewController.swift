//
//  DetailViewController.swift
//  MovieApp
//
//  Created by user194382 on 4/20/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var film: Film!
    var myCollection: [Film] = []
    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var ratingView: RatingController!
    @IBOutlet weak var filmCastLabel: UILabel!
    @IBOutlet weak var filmDirectorLabel: UILabel!
    @IBOutlet weak var filmGenreLabel: UILabel!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var filmYearLabel: UILabel!
    @IBOutlet weak var filmDescriptionLabel: UILabel!
    @IBOutlet weak var filmPosterImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.filmTitleLabel.text = film.name
        self.filmDescriptionLabel.text = film.description
        self.filmDescriptionLabel.lineBreakMode = .byTruncatingTail
        self.filmDescriptionLabel.numberOfLines = 0
        self.filmYearLabel.text = film.year
        self.filmCastLabel.text = film.actors
        self.filmDirectorLabel.text = film.director
        self.filmGenreLabel.text = film.genre
        self.filmCastLabel.numberOfLines = 0
        self.ratingView.starsRating = film.rating
                
        DispatchQueue.global(qos: .userInitiated).async {
            let filmImageData = NSData(contentsOf: URL(string: self.film!.imageUrl)!)
            DispatchQueue.main.async {
                self.filmPosterImage.image = UIImage(data: filmImageData as! Data)
                self.filmPosterImage.layer.cornerRadius = self.filmPosterImage.frame.width/2

        // Do any additional setup after loading the view.
    }
            
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    @IBAction func rateFilm(_ sender: Any) {
        self.film.rating = self.ratingView.starsRating
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (film.watchList == false) {
            addButton.setTitle("Add to Watch List", for: .normal)
        } else {
            addButton.setTitle("Remove from Watch List", for: .normal)
        }
    }
    
    @IBAction func addToCollection(_ sender: Any) {
        if (film.watchList == true) {
            film.watchList = false
        } else {
            film.watchList = true
        }
        viewWillAppear(false)
    }
    
    
    
}
