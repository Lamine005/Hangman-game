//
//  Score+CoreDataProperties.swift
//  
//
//  Created by Lamine Djobo on 2023-10-19.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var gameType: String?
    @NSManaged public var score: Int16
    @NSManaged public var username: String?

}

extension Score : Identifiable {

}
