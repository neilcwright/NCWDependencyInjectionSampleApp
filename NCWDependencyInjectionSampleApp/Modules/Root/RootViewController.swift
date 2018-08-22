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
    func redetermineInitialFlow()
}

final class RootViewController:
    UIViewController,
    RootViewControllerType,
    RootPresenterToViewType {
    
    private let presenter: RootPresenterType
    
    // MARK: View elements
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel.newAutoLayout()
        headerLabel.font = UIFont.preferredFont(
            forTextStyle: .headline,
            compatibleWith: self.traitCollection
        )
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.text = RootLocalization.titleText
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter.determineInitialView()
    }
    
    override func updateViewConstraints() {
        self.headerLabel.autoCenterInSuperview()
        super.updateViewConstraints()
    }
    
    // MARK: RootPresenterToViewType
    
    func redetermineInitialFlow() {
        self.presenter.determineInitialView()
    }
}

