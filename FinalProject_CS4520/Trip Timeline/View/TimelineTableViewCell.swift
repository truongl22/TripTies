//
//  TimelineTableViewCell.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/20/23.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelUsername: UILabel!
    var labelCaption: UILabel!
    var labelDate: UILabel!
    
    var mapPin: UIImageView!
    var labelLocation: UILabel!
    
    var commentIcon: UIButton!
    var comments: UILabel!
    
    var likeIcon: UIButton!
    var likes: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        setupWrapperCellView()
        setupLabelUsername()
        setupLocation()
        setuplabelCaption()
        setupLabelDate()
        setupComments()
        setupLikes()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 15.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelUsername(){
        labelUsername = UILabel()
        labelUsername.font = UIFont.boldSystemFont(ofSize: 16)
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelUsername)
    }
    
    func setupLocation() {
        mapPin = UIImageView(image: UIImage(systemName: "mappin.circle"))
        mapPin.translatesAutoresizingMaskIntoConstraints = false
        mapPin.tintColor = .black
        wrapperCellView.addSubview(mapPin)
        
        labelLocation = UILabel()
        labelLocation.font = UIFont.boldSystemFont(ofSize: 14)
        labelLocation.textColor = .black
        labelLocation.text = "Earth"
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLocation)
    }
    
    func setuplabelCaption(){
        labelCaption = UILabel()
        labelCaption.font = UIFont.systemFont(ofSize: 14)
        labelCaption.numberOfLines = 0
        labelCaption.lineBreakMode = .byWordWrapping
        labelCaption.sizeToFit()
        labelCaption.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCaption)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.italicSystemFont(ofSize: 10)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }
    
    func setupComments() {
        commentIcon = UIButton(type: .system)
        commentIcon.setImage(UIImage(systemName: "bubble.right.fill"), for: .normal)
        commentIcon.tintColor = .purple
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(commentIcon)
        
        comments = UILabel()
        comments.textColor = .purple
        comments.text = "0 comments"
        comments.font = UIFont.boldSystemFont(ofSize: 15)
        comments.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(comments)
    }
    
    func setupLikes() {
        likeIcon = UIButton(type: .system)
        likeIcon.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeIcon.tintColor = .red
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(likeIcon)
        
        likes = UILabel()
        likes.textColor = .red
        likes.text = "0 likes"
        likes.font = UIFont.boldSystemFont(ofSize: 15)
        likes.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(likes)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            labelUsername.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelUsername.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelUsername.heightAnchor.constraint(equalToConstant: 20),
            labelUsername.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),

            labelCaption.topAnchor.constraint(equalTo: mapPin.bottomAnchor, constant: 12),
            labelCaption.leadingAnchor.constraint(equalTo: labelUsername.leadingAnchor),
            labelCaption.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

            labelDate.topAnchor.constraint(equalTo: labelUsername.topAnchor),
            labelDate.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelDate.heightAnchor.constraint(equalToConstant: 16),
            labelDate.widthAnchor.constraint(lessThanOrEqualTo: labelUsername.widthAnchor),

            mapPin.topAnchor.constraint(equalTo: labelUsername.bottomAnchor, constant: 1),
            mapPin.trailingAnchor.constraint(equalTo: labelLocation.leadingAnchor, constant: -5),
                        mapPin.heightAnchor.constraint(equalToConstant: 16),
                        mapPin.widthAnchor.constraint(equalToConstant: 16),
            
            labelLocation.centerYAnchor.constraint(equalTo: mapPin.centerYAnchor),
            labelLocation.trailingAnchor.constraint(equalTo: labelDate.trailingAnchor),
            labelLocation.heightAnchor.constraint(equalToConstant: 16),
            
            commentIcon.leadingAnchor.constraint(equalTo: labelUsername.leadingAnchor),
            commentIcon.topAnchor.constraint(equalTo: labelCaption.bottomAnchor, constant: 7),
            commentIcon.widthAnchor.constraint(equalToConstant: 20),
            commentIcon.heightAnchor.constraint(equalToConstant: 20),
            
            comments.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 5),
            comments.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor),
            
            likeIcon.trailingAnchor.constraint(equalTo: likes.leadingAnchor, constant: -5),
            likeIcon.topAnchor.constraint(equalTo: labelCaption.bottomAnchor, constant: 7),
            likeIcon.widthAnchor.constraint(equalToConstant: 20),
            likeIcon.heightAnchor.constraint(equalToConstant: 20),
            
            likes.trailingAnchor.constraint(equalTo: labelDate.trailingAnchor, constant: -10),
            likes.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor)
        ])
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
