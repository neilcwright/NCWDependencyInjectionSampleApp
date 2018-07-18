//
//  LoginViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//

import UIKit

// MARK: View controller interface
protocol LoginViewControllerType: class {
    
}

final class LoginViewController:
    UIViewController,
    LoginViewControllerType,
    LoginPresenterToViewType {
    
    let presenter: LoginPresenterType
    
    // MARK: View elements
    
    fileprivate lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView.newAutoLayout()
        logoImageView.image = UIImage(named: "logo")
        return logoImageView
    }()

    fileprivate lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel.newAutoLayout()
        userNameLabel.numberOfLines = 0
        userNameLabel.lineBreakMode = .byWordWrapping
        userNameLabel.text = LoginLocalization.usernameLabel
        userNameLabel.textColor = UIColor.black
        return userNameLabel
    }()
    
    fileprivate lazy var userNameField: SimpleFormTextField = {
        let userNameField = SimpleFormTextField(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        userNameField.autocorrectionType = .no
        userNameField.layer.applyFormFieldStyle()
        userNameField.autocorrectionType = .no
        userNameField.autocapitalizationType = .none
        return userNameField
    }()
    
    fileprivate lazy var emailLabel: UILabel = {
        let emailLabel = UILabel.newAutoLayout()
        emailLabel.text = LoginLocalization.emailLabel
        emailLabel.numberOfLines = 0
        emailLabel.lineBreakMode = .byWordWrapping
        emailLabel.textColor = UIColor.black
        return emailLabel
    }()
    
    fileprivate lazy var emailField: SimpleFormTextField = {
        let emailField = SimpleFormTextField(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        emailField.autocorrectionType = .no
        emailField.layer.applyFormFieldStyle()
        emailField.autocapitalizationType = .none
        return emailField
    }()
    
    fileprivate lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel.newAutoLayout()
        passwordLabel.numberOfLines = 0
        passwordLabel.lineBreakMode = .byWordWrapping
        passwordLabel.text = LoginLocalization.passwordLabel
        passwordLabel.textColor = UIColor.black
        return passwordLabel
    }()
    
    fileprivate lazy var passwordField: SimpleFormTextField = {
        let passwordField = SimpleFormTextField(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        passwordField.isSecureTextEntry = true
        passwordField.layer.applyFormFieldStyle()
        return passwordField
    }()
    
    fileprivate lazy var submitButton: PrimaryButton = {
        let submitButton = PrimaryButton(
            viewModel: PrimaryButtonViewModel(
                cornerRadius: 5,
                horizontalInset: 20,
                verticalInset: 10
            ),
            delegate: self
        )
        submitButton.accessibilityIdentifier = "Submit-Button"
        submitButton.setTitle(LoginLocalization.submitButton, for: .normal)
        submitButton.tintColor = .blue
        submitButton.titleLabel?.textColor = .white
        return submitButton
    }()
    
    fileprivate lazy var createAccountButton: PrimaryButton = {
        let createAccountButton = PrimaryButton(
            viewModel: PrimaryButtonViewModel(
                cornerRadius: 5,
                horizontalInset: 20,
                verticalInset: 10
            ),
            delegate: self
        )
        createAccountButton.accessibilityIdentifier = "Create-Account-Button"
        createAccountButton.setTitle(LoginLocalization.createAccountButtonText, for: .normal)
        return createAccountButton
    }()
    
    fileprivate var didApplyConstraints: Bool = false

    // MARK: Initializers
    
    required init(presenter: LoginPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        self.setupViews()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        // apply constraints here
        if !self.didApplyConstraints {
            self.applyConstraints()
            self.didApplyConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

// MARK: PrimaryButtonDelegate
extension LoginViewController: PrimaryButtonDelegate {
    func handleTapEvent<T>(fromPrimaryButton button: T) where T : UIButton, T : PrimaryButtonType {
        switch button.accessibilityIdentifier {
        case self.submitButton.accessibilityIdentifier:
            self.presenter.handleLoginRequest(
                LoginRequest(
                    username: self.userNameField.text ?? "",
                    email: self.emailField.text ?? "",
                    password: self.passwordField.text ?? ""
                )
            )
        case self.createAccountButton.accessibilityIdentifier:
            self.presenter.handleCreateAccountRequest()
        default:
            break
        }
    }
}

// MARK: Private methods
private extension LoginViewController {
    
    func setupViews() {
        self.view.addSubview(self.logoImageView)
        self.view.addSubview(self.userNameLabel)
        self.view.addSubview(self.userNameField)
        self.view.addSubview(self.emailLabel)
        self.view.addSubview(self.emailField)
        self.view.addSubview(self.passwordLabel)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.submitButton)
        self.view.addSubview(self.createAccountButton)
    }
    
    func applyConstraints() {
        self.edgesForExtendedLayout = []

        let verticalInteritemSpacing: CGFloat = 20
        NSLayoutConstraint.activate([
            
            // logo image view
            self.logoImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 40),
            self.logoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 3.25/10),
            self.logoImageView.heightAnchor.constraint(equalTo: self.logoImageView.widthAnchor),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    
            // username label
            self.userNameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.logoImageView.bottomAnchor),
            self.userNameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.userNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // username field
            self.userNameField.topAnchor.constraint(
                equalTo: self.userNameLabel.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.userNameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.userNameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // email label
            self.emailLabel.topAnchor.constraint(
                equalTo: self.userNameField.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.emailLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // email field
            self.emailField.topAnchor.constraint(
                equalTo: self.emailLabel.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.emailField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // password label
            self.passwordLabel.topAnchor.constraint(
                equalTo: self.emailField.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.passwordLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.passwordLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // password field
            self.passwordField.topAnchor.constraint(
                equalTo: self.passwordLabel.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // submit button
            self.submitButton.topAnchor.constraint(
                equalTo: self.passwordField.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.submitButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // create new account button
            self.createAccountButton.topAnchor.constraint(equalTo: self.submitButton.bottomAnchor, constant: verticalInteritemSpacing),
            self.createAccountButton.leadingAnchor.constraint(equalTo: self.submitButton.leadingAnchor),
            self.createAccountButton.trailingAnchor.constraint(equalTo: self.submitButton.trailingAnchor),
            self.createAccountButton.bottomAnchor.constraint(
                greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -verticalInteritemSpacing
            )
        ])
        
        self.userNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        self.userNameField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        self.emailLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        self.emailField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        self.passwordLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        self.passwordField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        self.submitButton.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        self.createAccountButton.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
    }
}
