//
//  CommentViewController.swift
//  FinalProject_CS4520
//
//  Created by John Rodrigues on 6/23/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class CommentViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let commentView = CommentView()
    let commentCell = CommentTableViewCell()
    var currentUser:FirebaseAuth.User?
    var tripId:String?
    var postId:String?
    var comments = [Comment]()
    
    let database = Firestore.firestore()

    override func loadView() {
        view = commentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: Observe Firestore database to display the chats list...
        self.database.collection("trips").document(self.tripId!).collection("timeline").document(self.postId!).collection("comments").addSnapshotListener(includeMetadataChanges: true, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.comments.removeAll()
                    for document in documents{
                        do{
                            let chat  = try document.data(as: Comment.self)
                            self.comments.append(chat)
                        }catch{
                        }
                    }
                    self.comments = self.comments.sorted { (obj1, obj2) -> Bool in
                        return obj1.dateTime.compare(obj2.dateTime) == .orderedAscending
                    }
                    self.commentView.comments.reloadData()
                    
                    if(self.comments.count != 0) {
                        let lastRowIndex = self.commentView.comments.numberOfRows(inSection: 0) - 1
                        let indexPath = IndexPath(row: lastRowIndex, section: 0)
                        self.commentView.comments.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Comments"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        
        //MARK: patching table view delegate and data source...
        self.commentView.comments.delegate = self
        self.commentView.comments.dataSource = self
        
        //MARK: removing the separator line...
        self.commentView.comments.separatorStyle = .none
        
        setupRightBarButton()
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
    
    @objc func addComment(){
        let addCommentViewController = AddCommentViewController()
        addCommentViewController.currentUser = currentUser
        addCommentViewController.postId = self.postId
        addCommentViewController.tripId = self.tripId
        navigationController?.pushViewController(addCommentViewController, animated: true)
    }
    
    func setupRightBarButton(){
        //MARK: user is logged in...
        
        let addPostIcon = UIBarButtonItem(
            image: UIImage(systemName: "plus.app.fill"),
            style: .plain,
            target: self,
            action: #selector(addComment)
        )
        
        navigationItem.rightBarButtonItem = addPostIcon
        
    }
}
