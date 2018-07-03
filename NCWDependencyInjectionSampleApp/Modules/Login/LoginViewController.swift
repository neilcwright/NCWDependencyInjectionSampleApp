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
    
    fileprivate lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel.newAutoLayout()
        userNameLabel.numberOfLines = 0
        userNameLabel.lineBreakMode = .byWordWrapping
        userNameLabel.text = LoginLocalization.usernameLabel
        userNameLabel.textColor = UIColor.black
        return userNameLabel
    }()
    
    fileprivate lazy var userNameField: UITextField = {
        let userNameField = UITextField.newAutoLayout()
        userNameField.autocorrectionType = .no
        userNameField.layer.applyFormFieldStyle()
        return userNameField
    }()
    
    fileprivate lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel.newAutoLayout()
        passwordLabel.numberOfLines = 0
        passwordLabel.lineBreakMode = .byWordWrapping
        passwordLabel.text = LoginLocalization.passwordLabel
        passwordLabel.textColor = UIColor.black
        return passwordLabel
    }()
    
    fileprivate lazy var passwordField: UITextField = {
        let passwordField = UITextField.newAutoLayout()
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
        submitButton.setTitle(LoginLocalization.submitButton, for: .normal)
        submitButton.tintColor = .blue
        submitButton.titleLabel?.textColor = .white
        return submitButton
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
    func handleTapEvent<T: PrimaryButtonType>(fromPrimaryButton button: T) {
        print("tap tappity tap")
    }
}

// MARK: Private methods
private extension LoginViewController {
    
    func setupViews() {
        self.view.addSubview(self.userNameLabel)
        self.view.addSubview(self.userNameField)
        self.view.addSubview(self.passwordLabel)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.submitButton)
    }
    
    func applyConstraints() {
        self.edgesForExtendedLayout = []
        
        let verticalInteritemSpacing: CGFloat = 20
        NSLayoutConstraint.activate([
    
            // username label
            self.userNameLabel.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: verticalInteritemSpacing
            ),
            self.userNameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.userNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // username field
            self.userNameField.topAnchor.constraint(
                equalTo: self.userNameLabel.bottomAnchor,
                constant: verticalInteritemSpacing
            ),
            self.userNameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 8/10),
            self.userNameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // password label
            self.passwordLabel.topAnchor.constraint(
                equalTo: self.userNameField.bottomAnchor,
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
            self.submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
