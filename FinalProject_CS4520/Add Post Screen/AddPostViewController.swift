//
//  AddPostViewController.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/20/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CoreLocation

class AddPostViewController: UIViewController {
    
    let addPostView = AddPostView()
    var datePicker: UIDatePicker!
    var tripId: String?
    var currentLocation = "Earth"
    var checkLocation = false
    let childProgressView = ProgressSpinnerViewController()
    
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = addPostView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
        addPostView.submitButton.addTarget(self, action: #selector(submitInfo), for: .touchUpInside)
        addPostView.locationBox.addTarget(self, action: #selector(canCheckLocation), for: .touchUpInside)
        changeNavColorToWhite()
    }
    
    @objc func canCheckLocation() {
        checkLocation = !checkLocation
        
        if(checkLocation) {
            var checkbox = UIImage(systemName: "checkmark.square.fill")
            checkbox = checkbox?.resized(to: CGSize(width: 20, height: 20))
            self.addPostView.locationBox.setImage(checkbox, for: .normal)
        } else {
            var checkbox = UIImage(systemName: "checkmark.square")
            checkbox = checkbox?.resized(to: CGSize(width: 20, height: 20))
            self.addPostView.locationBox.setImage(checkbox, for: .normal)
        }
    }
    
    func getLocation(completion: @escaping (String?) -> Void) {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        let location: CLLocation!
        location = locManager.location
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                print("Reverse geocoding error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found.")
                completion(nil)
                return
            }
            
            guard let country = placemark.country else {
                print("Country name not found.")
                completion(nil)
                return
            }
            
            completion(country)
        }
    }
    
    @objc func submitInfo() {
        if(checkLocation) {
            getLocation(completion: {country in
                if let country = country {
                    self.currentLocation = country
                    print(self.currentLocation)
                    
                    let caption = self.addPostView.postText.text!
                    let username = (self.currentUser?.displayName)!
                    let location = country
                    
                    let currentTimestamp = Timestamp(date: Date())
                    let newPost = Post(username: username, dateTime: currentTimestamp, caption: caption, location: location)
                    
                    if (!caption.isEmpty) {
                        self.addPost(newPost)
                        self.addPostView.postText.text = nil
                    } else {
                        self.showErrorAlert("Caption cannot be Empty!")
                    }
                } else {
                    self.currentLocation = "Earth"
                    print(self.currentLocation)
                    
                    let caption = self.addPostView.postText.text!
                    let username = (self.currentUser?.displayName)!
                    let location = "Earth"
                    
                    let currentTimestamp = Timestamp(date: Date())
                    let newPost = Post(username: username, dateTime: currentTimestamp, caption: caption, location: location)
                    
                    if (!caption.isEmpty) {
                        self.addPost(newPost)
                        self.addPostView.postText.text = nil
                    } else {
                        self.showErrorAlert("Caption cannot be Empty!")
                    }
                }
            })
        } else {
            self.currentLocation = "Earth"
            print(self.currentLocation)
            
            let caption = self.addPostView.postText.text!
            let username = (self.currentUser?.displayName)!
            let location = self.currentLocation
            
            let currentTimestamp = Timestamp(date: Date())
            let newPost = Post(username: username, dateTime: currentTimestamp, caption: caption, location: location)
            
            if (!caption.isEmpty) {
                self.addPost(newPost)
                self.addPostView.postText.text = nil
            } else {
                self.showErrorAlert("Caption cannot be Empty!")
            }
        }
    }
    
    func addPost(_ post: Post) {
        database.collection("trips").document(self.tripId!).collection("timeline").addDocument(data: ["username": post.username,
             "dateTime": post.dateTime,
             "caption": post.caption,
             "location": post.location,
             "comments": 0,
             "likes": 0],
        completion: {error in if error == nil {
                 self.hideActivityIndicator()
                 self.navigationController?.popViewController(animated: true)
             }
            else {
                self.hideActivityIndicator()
                self.showErrorAlert("Post could not be added to the database. Try again")
            }})
        
        
    }
    
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    func changeNavColorToWhite() {
        // Create a new instance of UIBarButtonItemAppearance
        let appearance = UIBarButtonItemAppearance()
        
        // Set the color of the back button
        appearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply the appearance to the navigation bar
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    func showErrorAlert(_ text: String){
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
}

extension AddPostViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}

extension AddPostViewController: UITextFieldDelegate {
    // UITextFieldDelegate method
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Define the maximum character limit
            let maxLength = 60
            
            // Calculate the new length of the text if the change is allowed
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            // Check if the updated text exceeds the maximum length
            if updatedText.count > maxLength {
                return false // Return false to prevent further typing
            }
            
            return true // Return true to allow the change
        }
}
