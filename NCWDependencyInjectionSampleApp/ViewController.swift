//
//  ViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/15/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Initializers
    
    required init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

