//
//  ErrorViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

import UIKit

struct ErrorViewModel {
    let headerText: String
    let descriptionText: String
    let primaryButtonText: String
}

// MARK: View controller interface
protocol ErrorViewControllerType: class {
    
    /// Will bind the view model to the view controller instance and update its display.
    ///
    /// - Parameter viewModel: the view model to bind to this controller instance.
    func bind(viewModel: ErrorViewModel)
}

final class ErrorViewController:
    UIViewController,
    ErrorViewControllerType,
    ErrorPresenterToViewType {
    
    var viewModel: ErrorViewModel {
        didSet {
            self.headerLabel.text = self.viewModel.headerText
            self.descriptionLabel.text = self.viewModel.descriptionText
            self.primaryButton.setTitle(self.viewModel.primaryButtonText, for: .normal)
        }
    }
    
    let presenter: ErrorPresenterType
    
    // MARK: View elements
    
    fileprivate lazy var headerLabel: UILabel = {
        let headerLabel = UILabel.newAutoLayout()
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center
        headerLabel.text = ErrorLocalization.Generic.headerText
        headerLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.largeTitle, compatibleWith: self.traitCollection)
        return headerLabel
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel.newAutoLayout()
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = ErrorLocalization.Generic.descriptionText
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body, compatibleWith: self.traitCollection)
        return descriptionLabel
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_error"))
        imageView.configureForAutoLayout()
        return imageView
    }()
    
    fileprivate lazy var primaryButton: PrimaryButton = {
        let primaryButton = PrimaryButton(
            viewModel: PrimaryButtonViewModel(
                cornerRadius: 5,
                horizontalInset: 20,
                verticalInset: 10),
            delegate: self
        )
        primaryButton.setTitle(ErrorLocalization.Generic.primaryButtonText, for: .normal)
        return primaryButton
    }()
    
    fileprivate var didSetConstraints: Bool = false

    // MARK: Initializers
    
    required init(presenter: ErrorPresenterType) {
        self.presenter = presenter
        self.viewModel = ErrorViewModel(
            headerText: ErrorLocalization.Generic.headerText,
            descriptionText: ErrorLocalization.Generic.descriptionText,
            primaryButtonText: ErrorLocalization.Generic.primaryButtonText
        )
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        // add views here
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.primaryButton)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        // apply constraints here
        if !self.didSetConstraints {
            
            self.headerLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
            self.headerLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
            
            NSLayoutConstraint.activate([
                self.headerLabel.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.headerLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.headerLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.imageView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 20),
                self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 3/10),
                self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1),
                self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.descriptionLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
                self.descriptionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.descriptionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.primaryButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20),
                self.primaryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }
        
        super.updateViewConstraints()
    }
    
    func bind(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: PrimaryButtonDelegate
extension ErrorViewController: PrimaryButtonDelegate {
    func handleTapEvent<T>(fromPrimaryButton button: T) where T : PrimaryButtonType {
        self.presenter.handlePrimaryAction()
    }
}
