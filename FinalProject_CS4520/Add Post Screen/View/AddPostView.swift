//
//  AddPostView.swift
//  FinalProject_CS4520
//
//  Created by Lâm Trương on 6/20/23.
//

import UIKit

class AddPostView: UIView {
    var postBox: UIView!
    var postText: UITextView!
    var submitButton: UIButton!
    var contentWrapper:UIScrollView!
    
    var createPostLable: UILabel!
    var locationBox: UIButton!
    var locationLabel: UILabel!
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        
        setupContentWrapper()
        setupPostBox()
        setupPostText()
        setupSubmitButton()
        setUpCreatePostTitle()
        setupLocation()
        initConstraints()
    }
    
    func setupPostBox() {
        postBox = UIView()
        postBox.translatesAutoresizingMaskIntoConstraints = false
        
        contentWrapper.addSubview(postBox)
    }
    
    func setUpCreatePostTitle(){
        createPostLable = UILabel()
        createPostLable.text = "Create Post"
        createPostLable.textColor = .white
        createPostLable.font = UIFont.boldSystemFont(ofSize: 44)
        createPostLable.textAlignment = .center
        createPostLable.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(createPostLable)
    }
    
    func setupPostText() {
        postText = UITextView()
        postText.font = UIFont.systemFont(ofSize: 16)
        postText.layer.cornerRadius = 10
        postText.layer.borderWidth = 1
        postText.layer.borderColor = UIColor.white.cgColor
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.delegate = self
        
        postBox.addSubview(postText)
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
    
    func setupLocation() {
        locationBox = UIButton(type: .system)
        locationBox.tintColor = .white
        var checkbox = UIImage(systemName: "checkmark.square")
        checkbox = checkbox?.resized(to: CGSize(width: 20, height: 20))
        locationBox.setImage(checkbox, for: .normal)
        
        locationLabel = UILabel()
        locationLabel.text = "Tag location? (country)"
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .white
        
        stackView = UIStackView(arrangedSubviews: [locationBox, locationLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentWrapper.addSubview(stackView)
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
            
            createPostLable.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            createPostLable.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            postBox.topAnchor.constraint(equalTo: createPostLable.bottomAnchor, constant: 20),
            postBox.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor),
            postBox.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor),
            postBox.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            postText.topAnchor.constraint(equalTo: postBox.topAnchor, constant: 8),
            postText.leadingAnchor.constraint(equalTo: postBox.leadingAnchor, constant: 8),
            postText.trailingAnchor.constraint(equalTo: postBox.trailingAnchor, constant: -8),
            postText.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
            postText.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            postText.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            submitButton.topAnchor.constraint(equalTo: stackView.bottomAnchor , constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            postBox.bottomAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20) // Added constraint to prevent overlap
        ])
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return resizedImage
    }
}

// https://stackoverflow.com/questions/55196142/how-to-resize-a-uitextview-that-automatically-resize-its-width-and-height-based
extension AddPostView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: fixedWidth, height: max(newSize.height, 30))
        postText.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = max(newSize.height, 30)
            }
        }
        self.layoutIfNeeded()
        
        // Set the content size of the contentWrapper
        let totalHeight = postBox.frame.height + stackView.frame.height + submitButton.frame.height + 80
        contentWrapper.contentSize = CGSize(width: frame.width, height: totalHeight)
    }
}
