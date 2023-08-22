//
//  TripsTableViewManager.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/20/23.
//

import Foundation
import UIKit

extension UserHomePageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewTrips" , for: indexPath) as! TripsTableViewCell
        cell.backgroundColor = UIColor(red: 103, green: 71, blue: 200)
        cell.labelCityCountryName.text = tripsArray[indexPath.row].countryCity
        cell.labelDate.text = tripsArray[indexPath.row].date
        cell.labelTripDescription.text = tripsArray[indexPath.row].tripDes
        return cell
    }
    

}

