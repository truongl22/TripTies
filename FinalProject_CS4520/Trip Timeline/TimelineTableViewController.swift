//
//  TimelineTableViewController.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/23/23.
//

import Foundation
import UIKit

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewTimeline" , for: indexPath) as! TimelineTableViewCell
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formattedDate = formatDate.string(from: postsArray[indexPath.row].dateTime.dateValue())
        
        cell.labelUsername.text = "@" + postsArray[indexPath.row].username
        cell.labelDate.text = formattedDate
        cell.labelCaption.text = postsArray[indexPath.row].caption
        cell.labelLocation.text = postsArray[indexPath.row].location
        cell.labelCaption.sizeToFit()
        cell.comments.text = "\(postsArray[indexPath.row].comments)" + " comments"
        cell.likes.text = "\(postsArray[indexPath.row].likes)" + " likes"
        
        //MARK: set the bottom anchor of the wrapper to the bottom of the bottom-most subview...
        cell.wrapperCellView.bottomAnchor.constraint(equalTo: cell.comments.bottomAnchor, constant: 10).isActive = true
        
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(likePost(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        cell.contentView.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(commentOnPost(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.require(toFail: doubleTapGesture)
        cell.contentView.addGestureRecognizer(singleTapGesture)
        
        
        
        return cell
    }
}

