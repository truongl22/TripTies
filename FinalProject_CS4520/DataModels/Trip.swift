//
//  Trip.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/20/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct tripInfo: Codable{
    var countryCity: String
    var date: String
    var tripDes: String
    
    init(countryCity: String, date: String, tripDes: String) {
        self.countryCity = countryCity
        self.date = date
        self.tripDes = tripDes
    }
}


struct Trip: Codable {
    @DocumentID var id: String?
    var destination: String
    var arrivalDate: Timestamp
    var departureDate: Timestamp
    var createdBy: String
    var userArray: [String]
    var tripDescription: String
    var isSchengen: Bool
    var visaLength: String
    
    init(id: String? = nil, destination: String, arrivalDate: Timestamp, departureDate: Timestamp, createdBy: String, userArray: [String], tripDescription: String, isSchengen: Bool, visaLength: String) {
        self.id = id
        self.destination = destination
        self.arrivalDate = arrivalDate
        self.departureDate = departureDate
        self.createdBy = createdBy
        self.userArray = userArray
        self.tripDescription = tripDescription
        self.isSchengen = isSchengen
        self.visaLength = visaLength
    }
    
}
