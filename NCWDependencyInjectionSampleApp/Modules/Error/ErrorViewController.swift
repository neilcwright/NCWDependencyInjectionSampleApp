//
//  ErrorViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

import UIKit

// MARK: View controller interface
protocol ErrorViewControllerType: class {
    
}

final class ErrorViewController:
    UIViewController,
    ErrorViewControllerType,
    ErrorPresenterToViewType {
    
    let presenter: ErrorPresenterType
    
    // MARK: View elements
    
    fileprivate lazy var headerLabel: UILabel = {
        let headerLabel = UILabel.newAutoLayout()
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.textColor = .black
        headerLabel.text = ErrorLocalization.Generic.headerText
        headerLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1, compatibleWith: self.traitCollection)
        return headerLabel
    }()
    
    fileprivate var didSetConstraints: Bool = false

    // MARK: Initializers
    
    required init(presenter: ErrorPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        // add views here
        self.view.addSubview(self.headerLabel)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        // apply constraints here
        if !self.didSetConstraints {
            NSLayoutConstraint.activate([
                self.headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.headerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
        
        super.updateViewConstraints()
    }
}
