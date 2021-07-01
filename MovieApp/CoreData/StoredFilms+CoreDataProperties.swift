//
//  StoredFilms+CoreDataProperties.swift
//  MovieApp
//
//  Created by user194382 on 5/26/21.
//
//

import Foundation
import CoreData


extension StoredFilms {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredFilms> {
        return NSFetchRequest<StoredFilms>(entityName: "StoredFilms")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var confirmedDope: Bool
    @NSManaged public var imageUrl: String?
    @NSManaged public var year: String?
    @NSManaged public var collect: Bool
    @NSManaged public var actors: String?
    @NSManaged public var director: String?
    @NSManaged public var genre: String?
    @NSManaged public var search: String?

}

extension StoredFilms : Identifiable {

}
