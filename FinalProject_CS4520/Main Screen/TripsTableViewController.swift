//
//  TripsTableViewController.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_us")
        formatter.dateFormat = "MMMM dd yyyy"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewTrips" , for: indexPath) as! TripsTableViewCell
        cell.labelCityCountryName.text = tripsArray[indexPath.row].destination
        cell.labelDate.text = formatter.string(from: tripsArray[indexPath.row].arrivalDate.dateValue()) + " - " + formatter.string(from: tripsArray[indexPath.row].departureDate.dateValue())
        cell.labelTripDescription.text = tripsArray[indexPath.row].tripDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getTimeline(self.tripsArray[indexPath.row])
    }
}

