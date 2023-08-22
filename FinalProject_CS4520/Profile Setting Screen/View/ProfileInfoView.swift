//
//  ProfileInfoView.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/25/23.
//

import UIKit

class ProfileInfoView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!

    var imageProfile: UIImageView!
    
    var userNameLabel: UILabel!
    var dateOfBirthLabel: UILabel!
    var bioLabel: UILabel!
    var bioInfoLabel: UILabel!

    var editProfleButton: UIButton!
    var signOutButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        setupScrollView()
        setupContentView()
        setUpLogoImage()
        setupLabelUserName()
        setupLabelDateOfBirth()
        setupLabelBio()
        setupLabelBioInfo()
        setUpEditProfileButton()
        setUpSaveInfoButton()
        
        initConstraints()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setUpLogoImage(){
        imageProfile = UIImageView()
        imageProfile.image = UIImage(systemName: "person")
        imageProfile.contentMode = .scaleToFill
        imageProfile.clipsToBounds = true
        imageProfile.layer.cornerRadius = 10
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageProfile)
    }
    
    func setupLabelUserName(){
        userNameLabel = UILabel()
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        userNameLabel.textColor = .white
        userNameLabel.textAlignment = .center
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userNameLabel)
    }
    

    func setupLabelDateOfBirth(){
        dateOfBirthLabel = UILabel()
        dateOfBirthLabel.font = UIFont.italicSystemFont(ofSize: 14)
        dateOfBirthLabel.textColor = .white
        dateOfBirthLabel.textAlignment = .center
        dateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateOfBirthLabel)
    }
    
    func setupLabelBio(){
        bioLabel = UILabel()
        bioLabel.text = "Bio"
        bioLabel.font = UIFont.boldSystemFont(ofSize: 26)
        bioLabel.textColor = .white
        bioLabel.textAlignment = .center
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bioLabel)
    }
    
    func setupLabelBioInfo(){
        bioInfoLabel = UILabel()
        bioInfoLabel.font = UIFont.italicSystemFont(ofSize: 18)
        bioInfoLabel.numberOfLines = 0
        bioInfoLabel.textColor = .white
        bioInfoLabel.textAlignment = .center
        bioInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bioInfoLabel)
    }
    
    func setUpEditProfileButton(){
        editProfleButton = UIButton(type: .system)
        editProfleButton.setTitle("Edit", for: .normal)
        editProfleButton.layer.cornerRadius = 15.0
        editProfleButton.backgroundColor = UIColor(red: 54, green: 10, blue: 138)
        editProfleButton.setTitleColor(.white, for: .normal)
        editProfleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        editProfleButton.contentEdgeInsets =  UIEdgeInsets(top: 8, left: 46, bottom: 8, right: 46)
        editProfleButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(editProfleButton)
    }

    func setUpSaveInfoButton(){
        signOutButton = UIButton(type: .system)
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.layer.cornerRadius = 15.0
        signOutButton.backgroundColor = UIColor(red: 54, green: 10, blue: 138)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signOutButton.contentEdgeInsets =  UIEdgeInsets(top: 8, left: 30, bottom: 8, right: 30)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signOutButton)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            imageProfile.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 22),
            imageProfile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageProfile.heightAnchor.constraint(equalToConstant: 120),
            imageProfile.widthAnchor.constraint(equalToConstant: 120),
            
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 40),
            userNameLabel.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 10),
            userNameLabel.heightAnchor.constraint(equalToConstant: 27),
            
            dateOfBirthLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 7),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 10),
            dateOfBirthLabel.heightAnchor.constraint(equalToConstant: 27),
             
            bioLabel.topAnchor.constraint(equalTo: imageProfile.bottomAnchor , constant: 40),
            bioLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            bioInfoLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor , constant: 20),
            bioInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bioInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bioInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            editProfleButton.topAnchor.constraint(equalTo: bioInfoLabel.bottomAnchor,constant: 60),
            editProfleButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            signOutButton.topAnchor.constraint(equalTo: editProfleButton.bottomAnchor,constant: 14),
            signOutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
    

        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

