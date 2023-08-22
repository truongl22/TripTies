//
//  ProfileSettingViewController.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/18/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class ProfileSettingViewController: UIViewController {
    
    let settingView = ProfileSettingView()
    var pickedImage:UIImage?
    var delegate: ProfileInfoViewController!
    var datePicker: UIDatePicker!
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    let storage = Storage.storage()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingView.buttonImage.menu = getMenuImagePicker()
        settingView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        showDatePicker()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
        updateProfileData()
        settingView.buttonImage.setImage(pickedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.settingView.bioTextField.delegate = self
    }
    
    
    
    func updateProfileData() {
        database.collection("users").document((currentUser?.uid)!).getDocument(completion: {(document, error) in
            do {
                let profile = try document!.data(as: Profile.self)
                self.settingView.bioTextField.text = profile.bio
                self.settingView.userNameTextField.text = profile.username
                self.settingView.dateOfBirthTextField.text = profile.dob
                
            }
            catch {
                print(error)
            }
        })
    }
    
    func addProfileUrlToUser(photoURL: URL?) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = photoURL
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
                self.hideActivityIndicator()
            }else{
                self.navigationController?.popViewController(animated: true)
                self.hideActivityIndicator()
            }
        })

    }
    
    func uploadProfilePhotoToStorage(){
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage{
            if let jpegData = image.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\((currentUser?.uid)!).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                self.addProfileUrlToUser(photoURL: url)
                            }
                        })
                    }
                })
            }
        }else{
            self.navigationController?.popViewController(animated: true)
            self.hideActivityIndicator()
        }
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func showDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date

        datePicker?.preferredDatePickerStyle = .inline
        datePicker?.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        datePicker.maximumDate = Date()
     
        settingView.dateOfBirthTextField.inputView = datePicker
        settingView.dateOfBirthTextField.text = formatDate(date: Date())
        
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        settingView.dateOfBirthTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        return formatter.string(from: date)
    }
    
    
    @objc func saveButtonTapped(){
        if let unwrappedName = settingView.userNameTextField.text, let unwrappedDateOfBirth = settingView.dateOfBirthTextField.text, let unwrappedBio = settingView.bioTextField.text{
            if unwrappedName.isEmpty || unwrappedDateOfBirth.isEmpty            {
                showErrorAlert(message: "Please complete the fields to continue")
            }
            else{
//                let editedProfile = Profile(username: unwrappedName, dob: unwrappedDateOfBirth, bio: unwrappedBio, img: pickedImage ?? (UIImage(systemName: "person"))!)
                self.showActivityIndicator()
                
                database.collection("users").document((currentUser?.uid)!).updateData(["username": unwrappedName, "dob": unwrappedDateOfBirth, "bio": unwrappedBio])
                uploadProfilePhotoToStorage()
                
                
            }
        }
    }
    
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: "Error! \(message)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
        print("error function")
    }
    
    func getMenuImagePicker() -> UIMenu{
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
        
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
        
    }
    
}

extension ProfileSettingViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.settingView.buttonImage.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

extension ProfileSettingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.settingView.buttonImage.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}

extension ProfileSettingViewController: UITextFieldDelegate {
    // UITextFieldDelegate method
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Define the maximum character limit
            let maxLength = 35
            
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
