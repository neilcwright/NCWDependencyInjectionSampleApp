//
//  HomeTabBarViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: View controller interface
protocol HomeTabBarViewControllerType: class {
    
}

final class HomeTabBarViewController:
    UITabBarController,
    HomeTabBarViewControllerType,
    HomeTabBarPresenterToViewType {
    
    let presenter: HomeTabBarPresenterType
    
    // MARK: View elements

    // MARK: Initializers
    
    required init(presenter: HomeTabBarPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        // add views here
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        // apply constraints here
        super.updateViewConstraints()
    }
}
