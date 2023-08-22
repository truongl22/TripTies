//
//  ExistingTripsTableViewCell.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/24/23.
//

import UIKit

class ExistingTripsTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelCityCountryName: UILabel!
    var labelTripDescription: UILabel!
    var labelDate: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupLabelCityCountryName()
        setupLabelTripDescription()
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
    
    func setupLabelCityCountryName(){
        labelCityCountryName = UILabel()
        labelCityCountryName.font = UIFont.boldSystemFont(ofSize: 22)
        labelCityCountryName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCityCountryName)
    }
    
    func setupLabelTripDescription(){
        labelTripDescription = UILabel()
        labelTripDescription.font = UIFont.systemFont(ofSize: 14)
        labelTripDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTripDescription)
    }

    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.boldSystemFont(ofSize: 14)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 6),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -6),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.heightAnchor.constraint(equalToConstant: 98),
            
            labelCityCountryName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelCityCountryName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelCityCountryName.heightAnchor.constraint(equalToConstant: 20),
            labelCityCountryName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelTripDescription.topAnchor.constraint(equalTo: labelCityCountryName.bottomAnchor, constant: 12),
            labelTripDescription.leadingAnchor.constraint(equalTo: labelCityCountryName.leadingAnchor),
            labelTripDescription.heightAnchor.constraint(equalToConstant: 16),
            labelTripDescription.widthAnchor.constraint(lessThanOrEqualTo: labelCityCountryName.widthAnchor),

            labelDate.topAnchor.constraint(equalTo: labelTripDescription.bottomAnchor, constant: 12),
            labelDate.leadingAnchor.constraint(equalTo: labelTripDescription.leadingAnchor),
            labelDate.heightAnchor.constraint(equalToConstant: 16),
            labelDate.widthAnchor.constraint(lessThanOrEqualTo: labelCityCountryName.widthAnchor),
            
        
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
