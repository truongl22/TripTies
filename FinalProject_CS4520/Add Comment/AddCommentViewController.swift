//
//  AddCommentViewController.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/20/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CoreLocation

class AddCommentViewController: UIViewController {
    
    var tripId: String?
    var postId: String?
    let childProgressView = ProgressSpinnerViewController()
    
    var currentUser:FirebaseAuth.User?
    var addCommentView = AddCommentView()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = addCommentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
        addCommentView.submitButton.addTarget(self, action: #selector(submitInfo), for: .touchUpInside)
        changeNavColorToWhite()
    }
    
    @objc func submitInfo() {
        let comment = self.addCommentView.commentText.text!
        let username = (self.currentUser?.displayName)!
        
        let currentTimestamp = Timestamp(date: Date())
        let newComment = Comment(username: username, dateTime: currentTimestamp, comment: comment)
        
        if (!comment.isEmpty) {
            self.addComment(newComment)
            self.addCommentView.commentText.text = nil
        } else {
            self.showErrorAlert("Caption cannot be Empty!")
        }
    }
    
    func addComment(_ comment: Comment) {
        var emptyComments: [Comment] = []
        
        database.collection("trips").document(self.tripId!).collection("timeline").document(self.postId!).collection("comments").addDocument(data: ["username": comment.username,
                                                                                                                                                    "dateTime": comment.dateTime,
                                                                                                                                                    "comment": comment.comment
                                                                                                                                                   ],
                                                                                                                                             completion: {error in if error == nil {
                                                                                                                                                 
                                                                                                                                                 // Reference the document you want to update
                                                                                                                                                 let documentRef = self.database.collection("trips").document(self.tripId!).collection("timeline").document(self.postId!)
                                                                                                                                                 
                                                                                                                                                 // Read the current value of the field
                                                                                                                                                 documentRef.getDocument { (document, error) in
                                                                                                                                                     if let document = document, document.exists {
                                                                                                                                                         if var currentValue = document.data()?["comments"] as? Int {
                                                                                                                                                             // Calculate the new value by incrementing
                                                                                                                                                             currentValue += 1
                                                                                                                                                             
                                                                                                                                                             // Update the field with the new value
                                                                                                                                                             documentRef.setData([
                                                                                                                                                                "comments": currentValue
                                                                                                                                                             ], merge: true) { error in
                                                                                                                                                                 if let error = error {
                                                                                                                                                                     print("Error updating document: \(error)")
                                                                                                                                                                 } else {
                                                                                                                                                                     print("Document updated successfully")
                                                                                                                                                                 }
                                                                                                                                                             }
                                                                                                                                                         } else {
                                                                                                                                                             print("Field not found or not an integer")
                                                                                                                                                         }
                                                                                                                                                     } else {
                                                                                                                                                         print("Document does not exist or there was an error")
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 self.hideActivityIndicator()
                                                                                                                                                 self.navigationController?.popViewController(animated: true)
                                                                                                                                             }
            else {
                self.hideActivityIndicator()
                self.showErrorAlert("Comment could not be added to the database. Try again")
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

extension AddCommentViewController:ProgressSpinnerDelegate{
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
