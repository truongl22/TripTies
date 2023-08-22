//
//  UserHomePageView.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/20/23.
//

import UIKit

class UserHomePageView: UIView {
    var tripTitle: UILabel!
    var tableViewTrips: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        
        setUpTripLabel()
        setUpTableViewTrips()
        initConstraints()
    }
    
    func setUpTripLabel(){
        tripTitle = UILabel()
        tripTitle.text = "My Trips"
        tripTitle.textColor = .white
        tripTitle.font = .boldSystemFont(ofSize: 38)
        tripTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tripTitle)
    }
    
    func setUpTableViewTrips(){
        tableViewTrips = UITableView()
        tableViewTrips.register(TripsTableViewCell.self, forCellReuseIdentifier: "tableViewTrips")
        tableViewTrips.backgroundColor = UIColor(red: 103, green: 71, blue: 200)
        tableViewTrips.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewTrips)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tripTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            tripTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            
            tableViewTrips.topAnchor.constraint(equalTo: tripTitle.bottomAnchor, constant: 20),
            tableViewTrips.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewTrips.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableViewTrips.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
           
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
