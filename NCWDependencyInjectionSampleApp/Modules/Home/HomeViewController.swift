//
//  HomeViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Inbound protocol interface
protocol HomeViewControllerType: class {

}

protocol HomeViewControllerDelegate: class {
    
}

final class HomeViewController: UIViewController, HomeViewControllerType {
    
    let presenter: HomePresenterType
    
    // MARK: Initializers
    
    init(presenter: HomePresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle methods
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
