//
//  CommentVIew.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/25/23.
//

import UIKit

class CommentView: UIView {

    var comments: UITableView!
    let color = UIColor(red: 103, green: 71, blue: 200)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = color
        
        setupTimeline()
        initConstraints()
    }
    
    func setupTimeline() {
        comments = UITableView(frame: .zero, style: .plain)
        comments.register(CommentTableViewCell.self, forCellReuseIdentifier: "tableViewComments")
        comments.backgroundColor = color
        comments.separatorColor = color
        comments.tableFooterView = UIView()
        comments.superview?.backgroundColor = UIColor(red: 103/255, green: 71/255, blue: 200/255, alpha: 1.0)
        comments.backgroundView = UIView()
        comments.backgroundView?.backgroundColor = UIColor(red: 103/255, green: 71/255, blue: 200/255, alpha: 1.0)
        comments.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(comments)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            comments.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            comments.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            comments.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            comments.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
