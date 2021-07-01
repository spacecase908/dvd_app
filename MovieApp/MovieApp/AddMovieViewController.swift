//
//  AddMovieViewController.swift
//  MovieApp
//
//  Created by user194382 on 6/1/21.
//

import UIKit

class AddMovieViewController: UIViewController {
    var movieTitle: String = ""
    var apiService: OmdbService!
    var collection: [Film] = []
    var callback: ((Film) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmTitleField.returnKeyType = .done
        addFilmButton.setTitle("Add to Collection", for: .normal)
        
        print(collection.count)

        // Do any additional setup after loading the view.
    }
    @IBOutlet var filmTitleField: UITextField!
    @IBOutlet weak var addFilmButton: UIButton!
    @IBAction func addFilm(_ sender: Any) {
        if let movieTitle = filmTitleField.text {
            apiService = OmdbService()
            apiService.getFilms(completion: { [self]films, error in
                                    guard let films = films, error == nil else {
                                        let alert = UIAlertController(title: "API error", message: "There was an error connecting to the API", preferredStyle: .alert)
                                        
                                        self.present(alert, animated: true, completion: nil)
                                        return
                                    }
                self.collection.append(contentsOf: films)
                callback?(films[0])
                print(self.collection.count)
            })
                
            }
        
        addFilmButton.setTitle("Film Added!", for: .normal)
        dismiss(animated: true, completion: nil)
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
