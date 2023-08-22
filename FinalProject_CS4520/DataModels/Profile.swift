//
//  Profile.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/25/23.
//

import Foundation
import UIKit

struct profile{
    var name: String
    var img: UIImage
    var dateOfBirth: String
    var bio: String
    
    init(name: String, dateOfBirth: String, bio: String, img: UIImage) {
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.bio = bio
        self.img = img
    }
}


struct Profile: Codable{
    var username: String
    var email: String
    var dob: String
    var bio: String
    
    init(username: String, email: String, dob: String, bio: String) {
        self.username = username
        self.email = email
        self.dob = dob
        self.bio = bio
    }
}
