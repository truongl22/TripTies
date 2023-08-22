//
//  MainScreenView.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/18/23.
//

import UIKit

class MainScreenView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var appTitle: UILabel!
    var sloganTitle: UILabel!
    var welcomeBackTitle: UILabel!
    var welcomeTitle: UILabel!
    
    var loginButton: UIButton!
    var signupButton: UIButton!
    
    var logoImage: UIImage!
    
    var tripTitle: UILabel!
    var tableViewTrips: UITableView!
    var schengenButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        setupScrollView()
        setupContentView()
        setUpAppTitle()
        setUpSloganTitle()
        setUpWelcomeBackTitle()
        setUpWelcomeTitle()
        setUpLoginButton()
        setUpSignUpButton()
        setupSchengenButton()
        setUpTripLabel()
        setUpTableViewTrips()
        
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
    
    
    func setUpAppTitle(){
        appTitle = UILabel()
        appTitle.text = "TripTies"
        appTitle.textColor = .white
        appTitle.font = UIFont.boldSystemFont(ofSize: 44)
        appTitle.textAlignment = .center
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(appTitle)
    }
    
    func setUpTripLabel(){
        tripTitle = UILabel()
        tripTitle.text = "My Trips"
        tripTitle.textColor = .white
        tripTitle.font = .boldSystemFont(ofSize: 38)
        tripTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tripTitle)
    }
    
    func setUpTableViewTrips() {
        tableViewTrips = UITableView(frame: .zero, style: .plain)
        tableViewTrips.register(TripsTableViewCell.self, forCellReuseIdentifier: "tableViewTrips")
        let color = UIColor(red: 103, green: 71, blue: 200)
        tableViewTrips.backgroundColor = color // Set the background color of the table view to clear
        tableViewTrips.separatorColor = color
        tableViewTrips.tableFooterView = UIView()
        tableViewTrips.superview?.backgroundColor = UIColor(red: 103/255, green: 71/255, blue: 200/255, alpha: 1.0)
        tableViewTrips.backgroundView = UIView()
        tableViewTrips.backgroundView?.backgroundColor = UIColor(red: 103/255, green: 71/255, blue: 200/255, alpha: 1.0)
        tableViewTrips.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewTrips)
    }

    
    func setUpSloganTitle(){
        sloganTitle = UILabel()
        sloganTitle.textColor = .white
        sloganTitle.text = "Here for all of your Social Travel Needs!"
        sloganTitle.font = UIFont.systemFont(ofSize: 18)
        sloganTitle.textAlignment = .center
        sloganTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sloganTitle)
    }
    
    func setUpWelcomeBackTitle(){
        welcomeBackTitle = UILabel()
        welcomeBackTitle.textColor = .white
        welcomeBackTitle.text = "Welcome Back!"
        welcomeBackTitle.font = UIFont.systemFont(ofSize: 18)
        welcomeBackTitle.textAlignment = .center
        welcomeBackTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(welcomeBackTitle)
    }
    
    func setUpWelcomeTitle(){
        welcomeTitle = UILabel()
        welcomeTitle.textColor = .white
        welcomeTitle.text = "Welcome!"
        welcomeTitle.font = UIFont.systemFont(ofSize: 18)
        welcomeTitle.textAlignment = .center
        welcomeTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(welcomeTitle)
    }
    
    func setUpLoginButton(){
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 15.0
        loginButton.backgroundColor = .white
        loginButton.setTitleColor(UIColor(red: 103, green: 71, blue: 200), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginButton.contentEdgeInsets =  UIEdgeInsets(top: 12, left: 126, bottom: 12, right: 126)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginButton)
    }
    
    func setUpSignUpButton(){
        signupButton = UIButton(type: .system)
        signupButton.setTitle("SignUp", for: .normal)
        signupButton.setTitleColor(UIColor(red: 103, green: 71, blue: 200), for: .normal)
        signupButton.layer.cornerRadius = 15.0
        signupButton.backgroundColor = .white
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signupButton.contentEdgeInsets =  UIEdgeInsets(top: 12, left: 120, bottom: 12, right: 120)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signupButton)
    }
    
    func setupSchengenButton() {
        schengenButton = UIButton(type: .system)
        schengenButton.setTitle("Check Schengen Stay", for: .normal)
        schengenButton.setTitleColor(UIColor(red: 103, green: 71, blue: 200), for: .normal)
        schengenButton.layer.cornerRadius = 15.0
        schengenButton.backgroundColor = .white
        schengenButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        schengenButton.contentEdgeInsets =  UIEdgeInsets(top: 12, left: 120, bottom: 12, right: 120)
        schengenButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(schengenButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tripTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tripTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            
            schengenButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            schengenButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            tableViewTrips.topAnchor.constraint(equalTo: tripTitle.bottomAnchor, constant: 20),
            tableViewTrips.bottomAnchor.constraint(equalTo: schengenButton.topAnchor, constant: -8),
            tableViewTrips.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableViewTrips.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            appTitle.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 25),
            appTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            sloganTitle.topAnchor.constraint(equalTo: appTitle.bottomAnchor , constant: 40),
            sloganTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            welcomeBackTitle.topAnchor.constraint(equalTo: sloganTitle.bottomAnchor , constant: 120),
            welcomeBackTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: welcomeBackTitle.bottomAnchor , constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            welcomeTitle.topAnchor.constraint(equalTo: loginButton.bottomAnchor , constant: 40),
            welcomeTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            signupButton.topAnchor.constraint(equalTo: welcomeTitle.bottomAnchor , constant: 20),
            signupButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signupButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
