//
//  LoadingViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit
import PureLayout

class LoadingViewController: UIViewController {
    
    // MARK: Initializers
    
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.activityIndicatorViewStyle = .gray
        return activityIndicator
    }()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.applyConstraints()
    }
    
    // MARK: Private methods
    
    private func setupViews() {
        self.view.addSubview(self.activityIndicator)
    }
    
    private func applyConstraints() {
        self.edgesForExtendedLayout = []
        
        self.activityIndicator.autoPinEdgesToSuperviewEdges()
    }
}
