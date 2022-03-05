//
//  UserForm.swift
//  Locatly
//
//  Created by Sandeep Gautam on 02/02/2022.
//

import SwiftUI
import CoreData

struct UserForm: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var emailAddress = ""
    @State private var dateOfBirth = Date()
    @State private var orderCountry = OrderCountry.Nepal
    @State private var allowInternationalShipping = true
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var pinValue = ""
    @State private var cityName = ""
    @State private var zipCode = ""
    @State private var provinceName = ""
    @State private var countryName = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Phone Number", text: $phoneNumber)
                    TextField("Email Address", text: $emailAddress)
                    
                }
                
                Section(header: Text("Credentials")) {
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    Picker("Order Country", selection: $orderCountry) {
                        Text("Nepal").tag(OrderCountry.Nepal)
                        Text("India").tag(OrderCountry.India)
                        Text("Pakistan").tag(OrderCountry.Pakistan)
                        Text("Bangladesh").tag(OrderCountry.Bangladesh)
                    }
                    Toggle("Allow international shipping?", isOn: $allowInternationalShipping)
                    TextField("Card number", text: $cardNumber)
                    TextField("PIN", text: $pinValue)
                    TextField("Expiry Date", text: $expiryDate)
                    
                }
                
                Section(header: Text("Shipping Address")) {
                    TextField("City name", text: $cityName)
                    TextField("Zip code", text: $zipCode)
                    TextField("Province", text: $provinceName)
                    TextField("Country", text: $countryName)
                    
                }
                
                Button("Confirm User") {
                    let intermediateUser = IntermediateUser(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, emailAddress: emailAddress, dateOfBirth: dateOfBirth, orderCountry: orderCountry, allowInternationalShipping: allowInternationalShipping, cardNumber: cardNumber, expiryDate: expiryDate, pinValue: pinValue, cityName: cityName, zipCode: zipCode, provinceName: provinceName, countryName: countryName)
                    
                    createData(userToBeAdded: intermediateUser)
                    
                }
            }
            .navigationTitle("Add User")
        }
    }
    
    func createData(userToBeAdded usr: IntermediateUser) {
        
        //container is set in AppDelegate, so need to call that container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // create an entity and store user record
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        // adding the data with the user object passed
        let userVal = NSManagedObject(entity: userEntity, insertInto: managedContext)
        userVal.setValue(usr.zipCode, forKey: "zipCode")
        userVal.setValue(usr.userId, forKeyPath: "userId")
        userVal.setValue(usr.provinceName, forKey: "provinceName")
        userVal.setValue(usr.pinValue, forKey: "pinValue")
        userVal.setValue(usr.phoneNumber, forKey: "phoneNumber")
        userVal.setValue(usr.orderCountry, forKey: "orderCountry")
        userVal.setValue(usr.lastName, forKey: "lastName")
        userVal.setValue(usr.firstName, forKey: "firstName")
        userVal.setValue(usr.expiryDate, forKey: "expiryDate")
        userVal.setValue(usr.emailAddress, forKey: "emailAddress")
        userVal.setValue(usr.dateOfBirth, forKey: "dateOfBirth")
        userVal.setValue(usr.countryName, forKey: "countryName")
        userVal.setValue(usr.cityName, forKey: "cityName")
        userVal.setValue(usr.cardNumber, forKey: "cardNumber")
        userVal.setValue(usr.allowInternationalShipping, forKey: "allowInternationalShipping")
        
        //values have been set. Now, we save these values.
        do {
            try managedContext.save()
            MailSender().sendEmail(to: usr.emailAddress, subject: "Welcome to Locatly", body: getEmailBody(userData: usr))
        } catch let error as NSError {
            print("Could not save user. Error: \(error.localizedDescription)")
        }
    }
}

struct UserForm_Previews: PreviewProvider {
    static var previews: some View {
        UserForm()
.previewInterfaceOrientation(.portrait)
    }
}



