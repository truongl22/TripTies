//
//  SignUpViewController.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/18/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.submitButton.addTarget(self, action: #selector(onSubmitButtonTapped), for: .touchUpInside)
        
        changeNavColorToWhite()
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func changeNavColorToWhite() {
        // Create a new instance of UIBarButtonItemAppearance
        let appearance = UIBarButtonItemAppearance()

        // Set the color of the back button
        appearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Apply the appearance to the navigation bar
        navigationController?.navigationBar.tintColor = .white

    }
    
    @objc func onSubmitButtonTapped(){
        registerNewAccount()
    }
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        
        if let name = signUpView.userNameTextField.text,
           let email = signUpView.emailTextField.text,
           let dob = signUpView.dateOfBirthTextField.text,
           let password = signUpView.passWordTextField.text {
            if !name.isEmpty && !email.isEmpty && !password.isEmpty && !dob.isEmpty {
                if isValidEmail(email) {
                    if isValidDOB(dob) {
                        Auth.auth().createUser(withEmail: email.lowercased(), password: password, completion: {result, error in
                            if error == nil{
                                //MARK: the user creation is successful...
                                self.initializeUserDataInFireBase(username: name, email: email, dob: dob)
                                
                            }else{
                                //MARK: there is a error creating the user...
                                self.showErrorAlert(text: "Error creating User (Could be related to already existing email / user")
                            }
                        })
                    }
                    else {
                        showErrorAlert(text: "Invalid DOB")
                        hideActivityIndicator()
                    }
                } else {
                    showErrorAlert(text: "Invalid Email")
                    hideActivityIndicator()
                }
            }
            else {
                showErrorAlert(text: "Fields must not be empty")
                hideActivityIndicator()
            }
        }
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidDOB(_ dob: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Try parsing the DOB with slashes ("/")
        if let date = dateFormatter.date(from: dob) {
            let calendar = Calendar.current
            let currentDate = Date()
            let components = calendar.dateComponents([.year, .month, .day], from: date, to: currentDate)
            
            // Check if the calculated age is a valid range (e.g., not in the future and not too far in the past)
            let minAge = 0  // Minimum age in years
            let maxAge = 150  // Maximum age in years
            if let years = components.year, let months = components.month, let days = components.day,
               years >= minAge && years <= maxAge && (years > 0 || months > 0 || days >= 0) {
                return true
            }
        }
        
        // Try parsing the DOB without slashes ("/")
        dateFormatter.dateFormat = "MMddyy"
        if let date = dateFormatter.date(from: dob) {
            let calendar = Calendar.current
            let currentDate = Date()
            let components = calendar.dateComponents([.year, .month, .day], from: date, to: currentDate)
            
            // Check if the calculated age is a valid range (e.g., not in the future and not too far in the past)
            let minAge = 0  // Minimum age in years
            let maxAge = 150  // Maximum age in years
            if let years = components.year, let months = components.month, let days = components.day,
               years >= minAge && years <= maxAge && (years > 0 || months > 0 || days >= 0) {
                return true
            }
        }
        
        return false
    }
    
    func initializeUserDataInFireBase(username: String, email: String, dob :String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                self.addToUsersFireStore(id: (Auth.auth().currentUser?.uid)!, username: username, email: email, dob: dob)
                
            }else{
                //MARK: there was an error updating the profile...
                self.showErrorAlert(text: "Error updating the profile")
            }
        })
    }
    
    func addToUsersFireStore(id: String, username: String, email: String, dob: String){
        let collectionUsers = database
            .collection("users")
        
        do{
            collectionUsers.document(id).setData(["email": email.lowercased(), "username": username, "dob": dob, "bio": ""], completion: {(error) in
                if error == nil{
                    self.hideActivityIndicator()
                    self.navigationController?.popViewController(animated: true)
                }
            })
            
        }
    }
    
    func showErrorAlert(text:String) {
        let alert = UIAlertController(title: "Error!", message: "\(text)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
}

