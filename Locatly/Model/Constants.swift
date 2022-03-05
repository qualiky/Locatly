//
//  Constants.swift
//  Locatly
//
//  Created by Sandeep Gautam on 02/02/2022.
//

import Foundation

enum OrderCountry {
    case Nepal;
    case India;
    case Pakistan;
    case Bangladesh;
}

func getEmailBody(userData user: IntermediateUser) -> String {
    return "Hello, \(user.firstName),\nWelcome to Locatly!\nHere are the user details that you have entered.\nName:\(user.firstName) \(user.lastName)\nPhone number:\(user.phoneNumber)\nEmail Address:\(user.emailAddress)\nDate of birth:\(user.dateOfBirth)\nOrder Country:\(getUserOrderCountry(countryCode: user.orderCountry))\nInternational Shipping: \(getInternationalShippingStatus(allowInternationalShipping: user.allowInternationalShipping))\nLocation:\(user.cityName)-\(user.zipCode),\(user.provinceName),\(user.countryName)\nIf any of these details are incorrect, please use the app to change your incorrect information.\nThank you\nTeam Locatly."
}

func getUserOrderCountry(countryCode val: Int) -> String {
    switch val {
    case 1: return "Nepal"
    case 2: return "India"
    case 3: return "Bangladesh"
    default: return "Pakistan"
    }
}

func getInternationalShippingStatus(allowInternationalShipping val: Bool) -> String {
    if val{
        return "Enabled"
    }
    else {
        return "Disabled"
    }
}
