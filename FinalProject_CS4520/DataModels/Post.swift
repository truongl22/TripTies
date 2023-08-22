//
//  Post.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/23/23.
//
import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Comment: Codable {
    @DocumentID var id: String?
    var username: String
    var dateTime: Timestamp
    var comment: String
    
    init(id: String? = nil, username: String, dateTime: Timestamp, comment: String) {
        self.id = id
        self.username = username
        self.dateTime = dateTime
        self.comment = comment
    }
}

struct Post: Codable{
    @DocumentID var id: String?
    var username: String
    var dateTime: Timestamp
    var caption: String
    var location: String
    var comments: Int
    var likes: Int

    init(id: String? = nil, username: String, dateTime: Timestamp, caption: String, location: String, comments: Int = 0, likes: Int = 0) {
        self.id = id
        self.username = username
        self.dateTime = dateTime
        self.caption = caption
        self.location = location
        self.comments = comments
        self.likes = likes
    }
}
