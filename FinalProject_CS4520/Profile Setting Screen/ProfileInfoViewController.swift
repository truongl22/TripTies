//
//  ProfileInfoViewController.swift
//  FinalProject_CS4520
//
//  Created by Aleksei Shilov on 6/25/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class ProfileInfoViewController: UIViewController {
    
    let profileInfoView = ProfileInfoView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    override func loadView() {
        view = profileInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileInfoView.editProfleButton.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        profileInfoView.signOutButton.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProfileData()
        if let url = self.currentUser?.photoURL{
            self.profileInfoView.imageProfile.loadRemoteImage(from: url)
        }
        
    }
    
    func updateProfileData() {
        database.collection("users").document((currentUser?.uid)!).getDocument(completion: {(document, error) in
            do {
                let profile = try document!.data(as: Profile.self)
                self.profileInfoView.bioInfoLabel.text = profile.bio
                self.profileInfoView.userNameLabel.text = profile.username
                self.profileInfoView.dateOfBirthLabel.text = profile.dob
                
            }
            catch {
                print(error)
            }
        })
    }
    
    @objc func editProfileButtonTapped(){
        let profileSettingViewController = ProfileSettingViewController()
        profileSettingViewController.currentUser = self.currentUser
        profileSettingViewController.pickedImage = self.profileInfoView.imageProfile.image
        navigationController?.pushViewController(profileSettingViewController, animated: true)
    }
    
    @objc func onLogOutButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: { [self](_) in
            do{
                try Auth.auth().signOut()
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("Error occured!")
            }
        })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(logoutAlert, animated: true)
    }
}
