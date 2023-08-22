import UIKit

class AddTripView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var destinationTextField: UITextField!
    var arrivalDateTextField: UITextField!
    var departureDateTextField: UITextField!
    var visaLengthTextField: UITextField!
    var tripDescriptionTextField: UITextField!
    var schengenBox: UIButton!
    var schengenLabel: UILabel!
    var stackView: UIStackView!
    
    var submitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor(red: 103, green: 71, blue: 200)
        self.backgroundColor = color
        setupScrollView()
        setupContentView()
        setupDestinationTextField()
        setupTextFieldArrivalDate()
        setupTextFieldDepartureDate()
        setupTextFieldVisaLength()
        setupSchengen()
        setupTextFieldTripDescription()
        setUpSubmitButton()
        initConstraints()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
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
    
    func setupSchengen() {
        schengenBox = UIButton(type: .system)
        schengenBox.tintColor = .white
        var checkbox = UIImage(systemName: "checkmark.square")
        checkbox = checkbox?.resized(to: CGSize(width: 20, height: 20))
        schengenBox.setImage(checkbox, for: .normal)
        
        schengenLabel = UILabel()
        schengenLabel.text = "Schengen Area? "
        schengenLabel.font = UIFont.systemFont(ofSize: 14)
        schengenLabel.textColor = .white
        
        stackView = UIStackView(arrangedSubviews: [schengenBox, schengenLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
    }
    
    func setupDestinationTextField(){
        destinationTextField = UITextField()
        destinationTextField.placeholder = "Destination"
        destinationTextField.leftViewMode = .always
        destinationTextField.leftView = UIView(frame: CGRect(x:0,y:0,width:8,height:0))
        destinationTextField.layer.cornerRadius = 15.0
        destinationTextField.backgroundColor = .white
        destinationTextField.layer.borderColor = UIColor.white.cgColor
        destinationTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(destinationTextField)
    }
    
    func setupTextFieldArrivalDate(){
        arrivalDateTextField = UITextField()
        arrivalDateTextField.placeholder = "MM/DD/YY"
        arrivalDateTextField.leftViewMode = .always
        arrivalDateTextField.leftView = UIView(frame: CGRect(x:0,y:0,width:8,height:0))
        arrivalDateTextField.layer.cornerRadius = 15.0
        arrivalDateTextField.backgroundColor = .white
        arrivalDateTextField.layer.borderColor = UIColor.white.cgColor
        arrivalDateTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrivalDateTextField)
    }
    
    func setupTextFieldDepartureDate(){
        departureDateTextField = UITextField()
        departureDateTextField.placeholder = "MM/DD/YY"
        departureDateTextField.leftViewMode = .always
        departureDateTextField.leftView = UIView(frame: CGRect(x:0,y:0,width:8,height:0))
        departureDateTextField.layer.cornerRadius = 15.0
        departureDateTextField.backgroundColor = .white
        departureDateTextField.layer.borderColor = UIColor.white.cgColor
        departureDateTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(departureDateTextField)
    }
    
    func setupTextFieldVisaLength(){
        visaLengthTextField = UITextField()
        visaLengthTextField.placeholder = "Visa Length"
        visaLengthTextField.leftViewMode = .always
        visaLengthTextField.leftView = UIView(frame: CGRect(x:0,y:0,width:8,height:0))
        visaLengthTextField.layer.cornerRadius = 15.0
        visaLengthTextField.backgroundColor = .white
        visaLengthTextField.layer.borderColor = UIColor.white.cgColor
        visaLengthTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(visaLengthTextField)
    }
    
    func setupTextFieldTripDescription(){
        tripDescriptionTextField = UITextField()
        tripDescriptionTextField.placeholder = "Trip Description (35 character limit)"
        tripDescriptionTextField.leftViewMode = .always
        tripDescriptionTextField.leftView = UIView(frame: CGRect(x:0,y:0,width:8,height:0))
        tripDescriptionTextField.layer.cornerRadius = 15.0
        tripDescriptionTextField.backgroundColor = .white
        tripDescriptionTextField.layer.borderColor = UIColor.white.cgColor
        tripDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tripDescriptionTextField)
    }
    
    func setUpSubmitButton(){
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.layer.cornerRadius = 15.0
        submitButton.backgroundColor = UIColor(red: 54, green: 10, blue: 138)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        submitButton.contentEdgeInsets =  UIEdgeInsets(top: 8, left: 30, bottom: 8, right: 30)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(submitButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            destinationTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 62),
            destinationTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            destinationTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            destinationTextField.heightAnchor.constraint(equalToConstant: 46),
            
            arrivalDateTextField.topAnchor.constraint(equalTo: destinationTextField.bottomAnchor , constant: 42),
            arrivalDateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            arrivalDateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            arrivalDateTextField.heightAnchor.constraint(equalToConstant: 46),
            
            departureDateTextField.topAnchor.constraint(equalTo: arrivalDateTextField.bottomAnchor , constant: 42),
            departureDateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            departureDateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            departureDateTextField.heightAnchor.constraint(equalToConstant: 46),
            
            visaLengthTextField.topAnchor.constraint(equalTo: departureDateTextField.bottomAnchor , constant: 42),
            visaLengthTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            visaLengthTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            visaLengthTextField.heightAnchor.constraint(equalToConstant: 46),
            
            stackView.topAnchor.constraint(equalTo: visaLengthTextField.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            tripDescriptionTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor , constant: 42),
            tripDescriptionTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            tripDescriptionTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            tripDescriptionTextField.heightAnchor.constraint(equalToConstant: 120),
            
            submitButton.topAnchor.constraint(equalTo: tripDescriptionTextField.bottomAnchor , constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
