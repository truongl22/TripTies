import UIKit

class ProfileSettingView: UIView {

    var scrollView: UIScrollView!
    var contentView: UIView!
    var buttonImage: UIButton!
    var userNameTextField: UITextField!
    var dateOfBirthTextField: UITextField!
    var bioTextField: UITextField!

    var saveButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        setupScrollView()
        setupContentView()
        setupbuttonTakePhoto()
        setupTextFieldUserName()
        setupTextFieldDateOfBirth()
        setupTextFieldBio()
        setUpSaveButton()
        
        initConstraints()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupbuttonTakePhoto() {
        buttonImage = UIButton(type: .system)
        buttonImage.setTitle("", for: .normal)
        buttonImage.setImage(UIImage(systemName: "person"), for: .normal)
        buttonImage.contentHorizontalAlignment = .fill
        buttonImage.contentVerticalAlignment = .fill
        buttonImage.imageView?.contentMode = .scaleAspectFit
        buttonImage.showsMenuAsPrimaryAction = true
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonImage)
    }
    
    
    func setupTextFieldUserName() {
        userNameTextField = UITextField()
        userNameTextField.placeholder = "Username"
        userNameTextField.leftViewMode = .always
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        userNameTextField.layer.cornerRadius = 15.0
        userNameTextField.backgroundColor = .white
        userNameTextField.layer.borderColor = UIColor.white.cgColor
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userNameTextField)
    }
    
    func setupTextFieldDateOfBirth() {
        dateOfBirthTextField = UITextField()
        dateOfBirthTextField.placeholder = "MM/DD/YY"
        dateOfBirthTextField.leftViewMode = .always
        dateOfBirthTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        dateOfBirthTextField.layer.cornerRadius = 15.0
        dateOfBirthTextField.backgroundColor = .white
        dateOfBirthTextField.layer.borderColor = UIColor.white.cgColor
        dateOfBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateOfBirthTextField)
    }
    
    func setupTextFieldBio() {
        bioTextField = UITextField()
        bioTextField.placeholder = "Bio (35 character limit)"
        bioTextField.leftViewMode = .always
        bioTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        bioTextField.layer.cornerRadius = 15.0
        bioTextField.backgroundColor = .white
        bioTextField.layer.borderColor = UIColor.white.cgColor
        bioTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bioTextField)
    }

    func setUpSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 15.0
        saveButton.backgroundColor = UIColor(red: 54, green: 10, blue: 138)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 30, bottom: 8, right: 30)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(saveButton)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            buttonImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            buttonImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonImage.widthAnchor.constraint(equalToConstant: 120),
            buttonImage.heightAnchor.constraint(equalToConstant: 120),
            
            userNameTextField.topAnchor.constraint(equalTo: buttonImage.bottomAnchor, constant: 44),
            userNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            userNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            userNameTextField.heightAnchor.constraint(equalToConstant: 46),
            
            dateOfBirthTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 44),
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 46),
            
            bioTextField.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: 44),
            bioTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            bioTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            bioTextField.heightAnchor.constraint(equalToConstant: 120),
            
            saveButton.topAnchor.constraint(equalTo: bioTextField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
