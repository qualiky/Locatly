//
//  User+CoreDataProperties.swift
//  Locatly
//
//  Created by Sandeep Gautam on 02/03/2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var emailAddress: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var orderCountry: Int16
    @NSManaged public var allowInternationalShipping: Bool
    @NSManaged public var cardNumber: String?
    @NSManaged public var expiryDate: String?
    @NSManaged public var pinValue: String?
    @NSManaged public var cityName: String?
    @NSManaged public var zipCode: String?
    @NSManaged public var provinceName: String?
    @NSManaged public var countryName: String?
    @NSManaged public var userId: UUID?

}

extension User : Identifiable {

}
