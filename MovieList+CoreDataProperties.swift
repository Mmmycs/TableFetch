//
//  MovieList+CoreDataProperties.swift
//  
//
//  Created by Macbook pro on 30/04/2021.
//
//

import Foundation
import CoreData


extension MovieList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieList> {
        return NSFetchRequest<MovieList>(entityName: "MovieList")
    }

    @NSManaged public var movieTitle: String?
    @NSManaged public var price: Double
    @NSManaged public var genre: String?
    @NSManaged public var artwork: String?
    @NSManaged public var desc: String?
    @NSManaged public var artistName: String?

}
