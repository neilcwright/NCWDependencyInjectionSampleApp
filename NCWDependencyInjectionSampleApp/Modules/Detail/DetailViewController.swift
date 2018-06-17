//
//  DetailViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Inbound protocol interface
protocol DetailViewControllerType: class {
    
}

protocol DetailViewControllerDelegate: class {
    
}


final class DetailViewController: UIViewController, DetailViewControllerType {
    
    // MARK: Initializers
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
