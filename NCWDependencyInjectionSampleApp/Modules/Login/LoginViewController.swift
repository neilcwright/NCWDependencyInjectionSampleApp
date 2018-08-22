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
    
    private let presenter: LoginPresenterType
    
    // MARK: View elements
    
    private var scrollView: UIScrollView?
    private var scrollContentView: UIView?
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView.newAutoLayout()
        logoImageView.image = UIImage(named: "logo")
        return logoImageView
    }()

    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel.newAutoLayout()
        userNameLabel.numberOfLines = 0
        userNameLabel.lineBreakMode = .byWordWrapping
        userNameLabel.text = LoginLocalization.usernameLabel
        userNameLabel.textColor = UIColor.black
        return userNameLabel
    }()
    
    private lazy var userNameField: SimpleFormTextField = {
        let userNameField = SimpleFormTextField(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        userNameField.autocorrectionType = .no
        userNameField.layer.applyFormFieldStyle()
        userNameField.autocorrectionType = .no
        userNameField.autocapitalizationType = .none
        return userNameField
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel.newAutoLayout()
        emailLabel.text = LoginLocalization.emailLabel
        emailLabel.numberOfLines = 0
        emailLabel.lineBreakMode = .byWordWrapping
        emailLabel.textColor = UIColor.black
        return emailLabel
    }()
    
    private lazy var emailField: SimpleFormTextField = {
        let emailField = SimpleFormTextField(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        emailField.autocorrectionType = .no
        emailField.layer.applyFormFieldStyle()
        emailField.autocapitalizationType = .none
        return emailField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel.newAutoLayout()
        passwordLabel.numberOfLines = 0
        passwordLabel.lineBreakMode = .byWordWrapping
        passwordLabel.text = LoginLocalization.passwordLabel
        passwordLabel.textColor = UIColor.black
        return passwordLabel
    }()
    
    private lazy var passwordField: SimpleFormTextField = {
        let passwordField = SimpleFormTextField(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        passwordField.isSecureTextEntry = true
        passwordField.layer.applyFormFieldStyle()
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
        submitButton.accessibilityIdentifier = "Submit-Button"
        submitButton.setTitle(LoginLocalization.submitButton, for: .normal)
        submitButton.tintColor = .blue
        submitButton.titleLabel?.textColor = .white
        return submitButton
    }()
    
    private lazy var createAccountButton: PrimaryButton = {
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
    
    private var didApplyConstraints: Bool = false

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView?.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
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
        let (scrollView, contentView) = self.view.addScrollViewWithContentView()
        self.scrollView = scrollView
        self.scrollContentView = contentView
        
        contentView.addSubview(self.logoImageView)
        contentView.addSubview(self.userNameLabel)
        contentView.addSubview(self.userNameField)
        contentView.addSubview(self.emailLabel)
        contentView.addSubview(self.emailField)
        contentView.addSubview(self.passwordLabel)
        contentView.addSubview(self.passwordField)
        contentView.addSubview(self.submitButton)
        contentView.addSubview(self.createAccountButton)
    }
    
    func applyConstraints() {
        self.edgesForExtendedLayout = []

        guard let scrollContentView = self.scrollContentView else {
            assertionFailure("expect scroll content view to be set prior to applying view constraints")
            return
        }
        
        let verticalInteritemSpacing: CGFloat = 20
        let commonWidthMultiplier: CGFloat = 8/10
        NSLayoutConstraint.activate([

            // logo image view
            self.logoImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 40),
            self.logoImageView.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: 3.25/10),
            self.logoImageView.heightAnchor.constraint(equalTo: self.logoImageView.widthAnchor),
            self.logoImageView.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
    
            // username label
            self.userNameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.logoImageView.bottomAnchor),
            self.userNameLabel.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: commonWidthMultiplier),
            self.userNameLabel.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            // username field
            self.userNameField.topAnchor.constraint(
                equalTo: self.userNameLabel.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.userNameField.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: commonWidthMultiplier),
            self.userNameField.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            // email label
            self.emailLabel.topAnchor.constraint(
                equalTo: self.userNameField.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.emailLabel.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: commonWidthMultiplier),
            self.emailLabel.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            // email field
            self.emailField.topAnchor.constraint(
                equalTo: self.emailLabel.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.emailField.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: commonWidthMultiplier),
            self.emailField.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            // password label
            self.passwordLabel.topAnchor.constraint(
                equalTo: self.emailField.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.passwordLabel.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: commonWidthMultiplier),
            self.passwordLabel.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            // password field
            self.passwordField.topAnchor.constraint(
                equalTo: self.passwordLabel.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.passwordField.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: commonWidthMultiplier),
            self.passwordField.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            // submit button
            self.submitButton.topAnchor.constraint(
                equalTo: self.passwordField.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.submitButton.widthAnchor.constraint(equalTo: scrollContentView.widthAnchor, multiplier: commonWidthMultiplier),
            self.submitButton.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            // create new account button
            self.createAccountButton.topAnchor.constraint(equalTo: self.submitButton.bottomAnchor, constant: verticalInteritemSpacing),
            self.createAccountButton.leadingAnchor.constraint(equalTo: self.submitButton.leadingAnchor),
            self.createAccountButton.trailingAnchor.constraint(equalTo: self.submitButton.trailingAnchor),
            self.createAccountButton.bottomAnchor.constraint(
                equalTo: scrollContentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -verticalInteritemSpacing
            )
        ])
    }
}
