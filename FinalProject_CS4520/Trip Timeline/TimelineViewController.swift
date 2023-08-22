//
//  TimelineViewController.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/23/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class TimelineViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let timelineView = TimelineView()
    let timelineCell = TimelineTableViewCell()
    var currentUser:FirebaseAuth.User?
    var tripId:String?
    var postsArray = [Post]()
    var isLiked = false
    
    let database = Firestore.firestore()

    override func loadView() {
        view = timelineView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: Observe Firestore database to display the chats list...
        self.database.collection("trips").document(self.tripId!).collection("timeline").addSnapshotListener(includeMetadataChanges: true, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.postsArray.removeAll()
                    for document in documents{
                        do{
                            let chat  = try document.data(as: Post.self)
                            self.postsArray.append(chat)
                        }catch{
                        }
                    }
                    self.postsArray = self.postsArray.sorted { (obj1, obj2) -> Bool in
                        return obj1.dateTime.compare(obj2.dateTime) == .orderedDescending
                    }
                    self.timelineView.timeline.reloadData()
                    
                    if(self.postsArray.count != 0) {
                        let firstRowIndex = 0
                        let indexPath = IndexPath(row: firstRowIndex, section: 0)
                        self.timelineView.timeline.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Timeline"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        
        //MARK: patching table view delegate and data source...
        timelineView.timeline.delegate = self
        timelineView.timeline.dataSource = self
        
        //MARK: removing the separator line...
        timelineView.timeline.separatorStyle = .none
        
        setupRightBarButton()
        changeNavColorToWhite()
        
        // Disable editing mode for the table view
        timelineView.timeline.isEditing = false
    }

    
    func changeNavColorToWhite() {
        // Create a new instance of UIBarButtonItemAppearance
        let appearance = UIBarButtonItemAppearance()

        // Set the color of the back button
        appearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Apply the appearance to the navigation bar
        navigationController?.navigationBar.tintColor = .white

    }
    
    func setupRightBarButton(){
        //MARK: user is logged in...
        
        let addPostIcon = UIBarButtonItem(
            image: UIImage(systemName: "plus.app.fill"),
            style: .plain,
            target: self,
            action: #selector(addNewPostButton)
        )
        
        navigationItem.rightBarButtonItem = addPostIcon
        
    }
    
    @objc func addNewPostButton() {
        let addPost = AddPostViewController()
        addPost.currentUser = currentUser
        addPost.tripId = tripId
        navigationController?.pushViewController(addPost, animated: true)
    }
    
    @objc func commentOnPost(_ gesture: UITapGestureRecognizer) {
        guard let cell = gesture.view?.superview as? TimelineTableViewCell else {
            return
        }
        
        if let indexPath = timelineView.timeline.indexPath(for: cell) {
            let post = postsArray[indexPath.row]
            let addComment = CommentViewController()
            addComment.postId = post.id
            addComment.tripId = self.tripId
            addComment.currentUser = currentUser
            navigationController?.pushViewController(addComment, animated: true)
        }
    }

    
    @objc func likePost(_ gesture: UITapGestureRecognizer) {
        guard let cell = gesture.view?.superview as? TimelineTableViewCell else {
            return
        }
        
        if let indexPath = timelineView.timeline.indexPath(for: cell) {
            let post = postsArray[indexPath.row]
            
            var likes = isLiked ? post.likes - 1 : post.likes + 1
            isLiked = !isLiked
            
            let documentRef = database.collection("trips").document(self.tripId!).collection("timeline").document(post.id!)
            
            documentRef.updateData(["likes": likes]) { error in
                if let error = error {
                    // Error occurred while updating the document
                    print("Error updating document: \(error)")
                } else {
                    // Field updated successfully
                    print("Field updated successfully.")
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer && otherGestureRecognizer is UITapGestureRecognizer {
            return true
        }
        return false
    }
}
