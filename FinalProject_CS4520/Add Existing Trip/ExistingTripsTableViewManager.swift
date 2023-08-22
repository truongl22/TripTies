//
//  ExistingTripsTableViewManager.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/24/23.
//

import Foundation
import UIKit

extension ExistingTripViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existingTripsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_us")
        formatter.dateFormat = "MMMM dd yyyy"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewExistingTrips" , for: indexPath) as! TripsTableViewCell
        cell.backgroundColor = UIColor(red: 103, green: 71, blue: 200)
        cell.labelCityCountryName.text = existingTripsArray[indexPath.row].destination
        cell.labelDate.text = formatter.string(from: existingTripsArray[indexPath.row].arrivalDate.dateValue()) + "-" + formatter.string(from: existingTripsArray[indexPath.row].departureDate.dateValue())
        cell.labelTripDescription.text = existingTripsArray[indexPath.row].tripDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addUserToExistingTrip(self.existingTripsArray[indexPath.row])
    }
}
