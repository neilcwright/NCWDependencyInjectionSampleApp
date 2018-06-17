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
    
    // MARK: Initializers
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
