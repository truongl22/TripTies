//
//  ExistingTripViewController.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/24/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ExistingTripViewController: UIViewController {
    
    let existingTripView = ExistingTripView()
    let database = Firestore.firestore()
    let notificationCenter = NotificationCenter.default

    var existingTripsArray = [Trip]()
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = existingTripView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        existingTripView.tableViewTrips.delegate = self
        existingTripView.tableViewTrips.dataSource = self
        
        //MARK: removing the separator line...
        existingTripView.tableViewTrips.separatorStyle = .none
        getExistingTrips()
        changeNavColorToWhite()
        
    }
    
    func changeNavColorToWhite() {
        // Create a new instance of UIBarButtonItemAppearance
        let appearance = UIBarButtonItemAppearance()

        // Set the color of the back button
        appearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Apply the appearance to the navigation bar
        navigationController?.navigationBar.tintColor = .white

    }
    
    func getExistingTrips() {
        self.existingTripsArray.removeAll()

        self.database.collection("trips").getDocuments(completion: {(querySnapshot, error) in
            if let documents = querySnapshot?.documents {
                self.existingTripsArray.removeAll()
                for document in documents {
                    do {
                        let trip = try document.data(as: Trip.self)
                        if !trip.userArray.contains((self.currentUser?.uid)!) {
                            self.existingTripsArray.append(trip)
                        }
                    } catch {
                        print(error)
                    }
                }
                self.existingTripsArray = self.existingTripsArray.sorted { (t1, t2) -> Bool in
                    return t1.arrivalDate.compare(t2.arrivalDate) == .orderedDescending
                }
                self.existingTripView.tableViewTrips.reloadData()
            }
        })
    }
    
    func addUserToExistingTrip(_ trip: Trip) {
        let documentRef = trip.id!
        self.database.collection("trips").document(documentRef).updateData(["userArray": FieldValue.arrayUnion([(currentUser?.uid)!])]) { (error) in
            if error == nil {
                self.notificationCenter.post(name: .userAdded, object: "success")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showErrorAlert("User not added!")
            }
        }
    }
    
    func showErrorAlert(_ text: String){
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}
