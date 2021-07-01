//
//  TabBarController.swift
//  MovieApp
//
//  Created by user194382 on 5/27/21.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var Collection: [Film] = []
    var filmService: FilmService!
    var apiService: OmdbService!

    
    var indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        indicator.center = self.view.center
        indicator.startAnimating()
        self.view.addSubview(indicator)
        
        self.filmService = FilmService()
        guard let confirmedService = self.filmService else {return}
        
        confirmedService.getFilms(completion: {films, error in
            guard let films = films, error == nil else {
                let alert = UIAlertController(title: "API error", message: "There was an error connecting to the API", preferredStyle: .alert)
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.Collection = films

            if (self.Collection.count == 0) {
                let alert = UIAlertController(title: "API error", message: "No movies were found :(", preferredStyle: .alert)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            print(self.viewControllers)
            let collectionNavVC = self.viewControllers![1] as? CollectionNavViewController
            let collectionVC = collectionNavVC?.viewControllers[0] as? CollectionListViewController
            collectionVC?.collection = self.Collection
            
            let movieNavVC = self.viewControllers![0] as? MovieListNavController
            
            let movieVC = movieNavVC?.viewControllers[0] as? MovieListViewController
            
            movieVC?.collection = self.Collection
            movieVC?.tableView.reloadData()
            
            let recVC = self.viewControllers![2] as? ReccomendViewController
            recVC?.collection = self.Collection
            
            self.indicator.stopAnimating()
        })
        

        
    }
    
    
    
}
