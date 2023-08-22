//
//  LogInViewController.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/18/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LogInViewController: UIViewController {

    let logInView = LogInView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = logInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInView.submitButton.addTarget(self, action: #selector(onSubmitButtonTapped), for: .touchUpInside)
        
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
        loginToAccount()
    }

    
    func loginToAccount() {
        showActivityIndicator()
        if let email = logInView.userNameTextField.text, let password = logInView.passWordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
                if error == nil{
                    self.hideActivityIndicator()
                    self.navigationController?.popViewController(animated: true)
                }else{
                    //MARK: alert that no user found or password wrong...
                    self.showErrorAlert("Incorrect Username/Password")
                    self.hideActivityIndicator()
                }
                
            })
        }
    }
    
    func showErrorAlert(_ text: String){
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}

