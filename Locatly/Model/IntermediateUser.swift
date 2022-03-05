//
//  IntermediateUser.swift
//  Locatly
//
//  Created by Sandeep Gautam on 04/03/2022.
//

import Foundation


struct IntermediateUser {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var emailAddress: String
    var dateOfBirth : Date
    var orderCountry: Int
    var allowInternationalShipping: Bool
    var cardNumber: String
    var expiryDate: String
    var pinValue: String
    var cityName: String
    var zipCode: String
    var provinceName: String
    var countryName: String
    var userId: String
    
    init(firstName fName: String, lastName lName: String, phoneNumber pNum: String, emailAddress email: String, dateOfBirth dob: Date, orderCountry oCountry: OrderCountry, allowInternationalShipping isInternational: Bool, cardNumber cardNum: String, expiryDate eDate: String, pinValue pVal: String, cityName cName: String, zipCode zpCode: String, provinceName pName: String, countryName cntryName: String) {
        self.firstName = fName;
        self.lastName = lName;
        self.phoneNumber = pNum;
        self.emailAddress = email;
        self.dateOfBirth = dob;
        
        switch oCountry {
            case .Nepal : orderCountry = 1
            case .India : orderCountry = 2
            case .Bangladesh : orderCountry = 3
            default : orderCountry = 4
        }
        
        self.allowInternationalShipping = isInternational;
        self.cardNumber = cardNum;
        self.expiryDate = eDate;
        self.pinValue = pVal;
        self.cityName = cName;
        self.zipCode = zpCode;
        self.provinceName = pName;
        self.countryName = cName;
        self.userId = UUID().uuidString
    }
}
