//
//  TimelineTableViewController.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/23/23.
//

import Foundation
import UIKit

extension CommentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewComments" , for: indexPath) as! CommentTableViewCell
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formattedDate = formatDate.string(from: comments[indexPath.row].dateTime.dateValue())
        
        cell.labelUsername.text = "@" + comments[indexPath.row].username
        cell.labelDate.text = formattedDate
        cell.labelCaption.text = comments[indexPath.row].comment
        cell.labelCaption.sizeToFit()
        
        //MARK: set the bottom anchor of the wrapper to the bottom of the bottom-most subview...
        cell.wrapperCellView.bottomAnchor.constraint(equalTo: cell.labelCaption.bottomAnchor, constant: 10).isActive = true

        return cell
    }
}

