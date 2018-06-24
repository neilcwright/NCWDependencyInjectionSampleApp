//
//  RootViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Inbound protocol interface
protocol RootViewControllerType: class {
    
}

protocol RootViewControllerDelegate: class {
    
}

final class RootViewController: UIViewController, RootViewControllerType {
    
    let presenter: RootPresenterType
    
    // MARK: View elements
    
    fileprivate lazy var headerLabel: UILabel = {
        let headerLabel = UILabel.newAutoLayout()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: self.traitCollection)
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.text = "Root View"
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        return headerLabel
    }()
    
    // MARK: Initializers
    
    required init(presenter: RootPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.headerLabel)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter.determineInitialView()
    }
    
    override func updateViewConstraints() {
        self.headerLabel.autoCenterInSuperview()
        super.updateViewConstraints()
    }
}
