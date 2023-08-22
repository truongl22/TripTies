//
//  AddCommentView.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/20/23.
//

import UIKit

class AddCommentView: UIView {
    var commentBox: UIView!
    var commentText: UITextView!
    var submitButton: UIButton!
    var contentWrapper:UIScrollView!
    
    var createCommentLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        
        setupContentWrapper()
        setupCommentBox()
        setupCommentText()
        setupSubmitButton()
        setUpCreateCommentTitle()
        initConstraints()
    }
    
    func setupCommentBox() {
        commentBox = UIView()
        commentBox.translatesAutoresizingMaskIntoConstraints = false
        
        contentWrapper.addSubview(commentBox)
    }
    
    func setUpCreateCommentTitle(){
        createCommentLable = UILabel()
        createCommentLable.text = "Create Comment"
        createCommentLable.textColor = .white
        createCommentLable.font = UIFont.boldSystemFont(ofSize: 44)
        createCommentLable.textAlignment = .center
        createCommentLable.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(createCommentLable)
    }
    
    func setupCommentText() {
        commentText = UITextView()
        commentText.font = UIFont.systemFont(ofSize: 16)
        commentText.layer.cornerRadius = 10
        commentText.layer.borderWidth = 1
        commentText.layer.borderColor = UIColor.white.cgColor
        commentText.translatesAutoresizingMaskIntoConstraints = false
        commentText.delegate = self
        
        commentBox.addSubview(commentText)
    }
    
    func setupSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.layer.cornerRadius = 15.0
        submitButton.backgroundColor = UIColor(red: 54, green: 10, blue: 138)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        submitButton.contentEdgeInsets =  UIEdgeInsets(top: 8, left: 30, bottom: 8, right: 30)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(submitButton)
    }
    
    //MARK: setting up UI elements...
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentWrapper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentWrapper.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            contentWrapper.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentWrapper.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            createCommentLable.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            createCommentLable.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            commentBox.topAnchor.constraint(equalTo: createCommentLable.bottomAnchor, constant: 20),
            commentBox.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor),
            commentBox.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor),
            commentBox.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            commentText.topAnchor.constraint(equalTo: commentBox.topAnchor, constant: 8),
            commentText.leadingAnchor.constraint(equalTo: commentBox.leadingAnchor, constant: 8),
            commentText.trailingAnchor.constraint(equalTo: commentBox.trailingAnchor, constant: -8),
            commentText.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -8),
            commentText.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            commentText.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            submitButton.topAnchor.constraint(equalTo: commentText.bottomAnchor , constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            commentBox.bottomAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20) // Added constraint to prevent overlap
        ])
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// https://stackoverflow.com/questions/55196142/how-to-resize-a-uitextview-that-automatically-resize-its-width-and-height-based
extension AddCommentView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: fixedWidth, height: max(newSize.height, 30))
        commentText.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = max(newSize.height, 30)
            }
        }
        self.layoutIfNeeded()
        
        // Set the content size of the contentWrapper
        let totalHeight = commentBox.frame.height + submitButton.frame.height + 80
        contentWrapper.contentSize = CGSize(width: frame.width, height: totalHeight)
    }
}
