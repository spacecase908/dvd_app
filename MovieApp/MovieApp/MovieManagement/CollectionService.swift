//
//  CollectionService.swift
//  MovieApp
//
//  Created by user194382 on 5/10/21.
//

import Foundation

class CollectionService {
    
    var collection: [Film] = []
    
    
    func addFilm(newFilm: Film) {
        
        self.collection.append(newFilm)
        
    }
}
