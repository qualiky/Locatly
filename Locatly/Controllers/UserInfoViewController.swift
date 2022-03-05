//
//  HistoryViewController.swift
//  Locatly
//
//  Created by Sandeep Gautam on 01/02/2022.
//

import UIKit
import SwiftUI
import CoreData

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    
    lazy var intermediateUserList = [IntermediateUser]()
    @IBOutlet weak var dataDisplayTable: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: Loading data from CoreData to an array of Users
        retrieveData()
        
        // the view controller itself is the delegate for data source
        dataDisplayTable.delegate = self
        dataDisplayTable.dataSource = self
        dataDisplayTable.rowHeight = UITableView.automaticDimension
        dataDisplayTable.estimatedRowHeight = 81
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intermediateUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell()
//        cell.textLabel?.text = intermediateUserList[indexPath.row].firstName
//        return cell
        
        let cell = dataDisplayTable.dequeueReusableCell(withIdentifier: "TableViewCellIdentifier") as! TableViewCell
        cell.nameLabel.text = "\(intermediateUserList[indexPath.row].firstName) \(intermediateUserList[indexPath.row].lastName)"
        cell.additionalDataLabel.text = "\(intermediateUserList[indexPath.row].cityName), \(intermediateUserList[indexPath.row].provinceName), \(intermediateUserList[indexPath.row].countryName)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataDisplayTable.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    @IBAction func onAddUserInfo(_ sender: UIBarButtonItem) {
        print("Add button clicked!")
        //switfui interop here
        let hostingController = UIHostingController(rootView: UserForm())
        present(hostingController, animated: true, completion: nil)
    }
    
    
    
    
    func retrieveData () {
        
        //refer to the AppDelegate Container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        //get the context from container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // prepare the request of type NSFetchRequest for view
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                
                let countryVal = data.value(forKey: "orderCountry") as! Int
                var orderCountryEnum = OrderCountry.Nepal
                
                switch countryVal {
                case 1: orderCountryEnum = OrderCountry.Nepal
                case 2: orderCountryEnum = OrderCountry.India
                case 3: orderCountryEnum = OrderCountry.Bangladesh
                default: orderCountryEnum = OrderCountry.Pakistan
                }
                
                intermediateUserList.append(
                    IntermediateUser(
                        firstName: data.value(forKey: "firstName") as! String,
                        lastName: data.value(forKey: "lastName") as! String,
                        phoneNumber: data.value(forKey: "phoneNumber") as! String,
                        emailAddress: data.value(forKey: "emailAddress") as! String,
                        dateOfBirth: data.value(forKey: "dateOfBirth") as! Date,
                        orderCountry: orderCountryEnum,
                        allowInternationalShipping: data.value(forKey: "allowInternationalShipping") as! Bool,
                        cardNumber: data.value(forKey: "cardNumber") as! String,
                        expiryDate: data.value(forKey: "expiryDate") as! String,
                        pinValue: data.value(forKey: "pinValue") as! String,
                        cityName: data.value(forKey: "cityName") as! String,
                        zipCode: data.value(forKey: "zipCode") as! String,
                        provinceName: data.value(forKey: "provinceName") as! String,
                        countryName: data.value(forKey: "countryName") as! String)
                )
            }
        } catch {
            print("Error: Could not retrieve data")
        }
    }
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
