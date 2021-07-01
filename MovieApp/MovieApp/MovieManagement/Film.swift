//
//  Bird.swift
//  AngryBirds
//
//  Created by user194382 on 4/7/21.
//

import Foundation
import CoreData

class Film: CustomDebugStringConvertible, Codable {
    var debugDescription: String {
        return "Film(name: \(self.name), description: \(self.description), year: \(self.year))"
    }
    
    var name: String
    var description: String
    var watched: Bool = false
    var imageUrl: String
    var year: String
    var watchList: Bool = false
    var actors: String
    var director: String
    var genre: String
    var search: String
    var rating: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case name, description, imageUrl, year, actors, director, genre, search
    }
    
    init(named name: String, description: String, imageUrl: String, year: String, actors: String, director: String, genre: String, search: String) {
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.year = year
        self.actors = actors
        self.director = director
        self.genre = genre
        self.search = search
    }
}

struct FilmResult: Codable {
    let films: [Film]
}
