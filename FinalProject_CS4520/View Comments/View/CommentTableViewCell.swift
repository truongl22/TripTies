//
//  CommentTableViewCell.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/20/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelUsername: UILabel!
    var labelCaption: UILabel!
    var labelDate: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        setupWrapperCellView()
        setupLabelUsername()
        setuplabelCaption()
        setupLabelDate()
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

            labelCaption.topAnchor.constraint(equalTo: labelUsername.bottomAnchor, constant: 20),
            labelCaption.leadingAnchor.constraint(equalTo: labelUsername.leadingAnchor),
            labelCaption.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

            labelDate.topAnchor.constraint(equalTo: labelUsername.topAnchor),
            labelDate.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelDate.heightAnchor.constraint(equalToConstant: 16),
            labelDate.widthAnchor.constraint(lessThanOrEqualTo: labelUsername.widthAnchor)
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
