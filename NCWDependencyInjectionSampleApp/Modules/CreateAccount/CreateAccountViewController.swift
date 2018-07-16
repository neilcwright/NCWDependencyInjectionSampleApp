//
//  CreateAccountViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-08-2018.
//

import UIKit

// MARK: View controller interface
protocol CreateAccountViewControllerType: class {
    
}

final class CreateAccountViewController:
    UIViewController,
    CreateAccountViewControllerType,
    CreateAccountPresenterToViewType {
    
    let presenter: CreateAccountPresenterType
    
    // MARK: View elements
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel.newAutoLayout()
        headerLabel.text = CreateAccountLocalization.headerText
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        return headerLabel
    }()
    
    private lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel.newAutoLayout()
        usernameLabel.text = CreateAccountLocalization.usernameLabelText
        usernameLabel.textColor = .black
        usernameLabel.textAlignment = .left
        usernameLabel.numberOfLines = 0
        usernameLabel.lineBreakMode = .byWordWrapping
        usernameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return usernameLabel
    }()
    
    private lazy var usernameField: UITextField = {
        let usernameField = UITextField.newAutoLayout()
        usernameField.placeholder = CreateAccountLocalization.usernameFieldText
        usernameField.layer.applyFormFieldStyle()
        usernameField.textColor = .black
        usernameField.textAlignment = .left
        usernameField.font = UIFont.preferredFont(forTextStyle: .body)
        return usernameField
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel.newAutoLayout()
        emailLabel.text = CreateAccountLocalization.emailLabelText
        emailLabel.textColor = .black
        emailLabel.textAlignment = .left
        emailLabel.numberOfLines = 0
        emailLabel.lineBreakMode = .byWordWrapping
        emailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return emailLabel
    }()

    private lazy var emailField: UITextField = {
        let emailField = UITextField.newAutoLayout()
        emailField.placeholder = CreateAccountLocalization.emailFieldPlaceholderText
        emailField.layer.applyFormFieldStyle()
        emailField.textColor = .black
        emailField.textAlignment = .left
        emailField.font = UIFont.preferredFont(forTextStyle: .body)
        return emailField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel.newAutoLayout()
        passwordLabel.text = CreateAccountLocalization.passwordLabelText
        passwordLabel.textColor = .black
        passwordLabel.textAlignment = .left
        passwordLabel.numberOfLines = 0
        passwordLabel.lineBreakMode = .byWordWrapping
        passwordLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return passwordLabel
    }()
    
    private lazy var passwordField: UITextField = {
        let passwordField = UITextField.newAutoLayout()
        passwordField.placeholder = CreateAccountLocalization.passwordFieldPlaceholderText
        passwordField.layer.applyFormFieldStyle()
        passwordField.isSecureTextEntry = true
        passwordField.textColor = .black
        passwordField.textAlignment = .left
        passwordField.font = UIFont.preferredFont(forTextStyle: .body)
        return passwordField
    }()
    
    private lazy var submitButton: PrimaryButton = {
        let submitButton = PrimaryButton(
            viewModel: PrimaryButtonViewModel(
                cornerRadius: 5,
                horizontalInset: 20,
                verticalInset: 10
            ),
            delegate: self
        )
        submitButton.setTitle(CreateAccountLocalization.submitButtonText, for: .normal)
        return submitButton
    }()
    
    private var didSetConstraints: Bool = false
    
    // MARK: Initializers
    
    required init(presenter: CreateAccountPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.emailLabel)
        self.view.addSubview(self.emailField)
        self.view.addSubview(self.usernameLabel)
        self.view.addSubview(self.usernameField)
        self.view.addSubview(self.passwordLabel)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.submitButton)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        // apply constraints here
        if !self.didSetConstraints {
            self.didSetConstraints = true
            
            NSLayoutConstraint.activate([
                self.headerLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 40),
                self.headerLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
                self.headerLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
                
                self.usernameLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 20),
                self.usernameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
                self.usernameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.usernameField.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 10),
                self.usernameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
                self.usernameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.emailLabel.topAnchor.constraint(equalTo: self.usernameField.bottomAnchor, constant: 20),
                self.emailLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
                self.emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.emailField.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 10),
                self.emailField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
                self.emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

                self.passwordLabel.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 10),
                self.passwordLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
                self.passwordLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.passwordField.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 10),
                self.passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
                self.passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.submitButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 10),
                self.submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
            
            self.usernameField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
            self.emailField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
            self.passwordField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        }
        super.updateViewConstraints()
    }
}

// MARK: PrimaryButtonDelegate
extension CreateAccountViewController: PrimaryButtonDelegate {
    func handleTapEvent<T>(fromPrimaryButton button: T) where T : PrimaryButtonType {
        self.presenter.requestNewAccount(
            username: self.usernameField.text ?? "",
            email: self.emailLabel.text ?? "",
            password: self.passwordField.text ?? ""
        )
    }
}
