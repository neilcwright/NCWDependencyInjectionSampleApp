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

final class HomeViewController: UIViewController, HomeViewControllerType {
    
    let presenter: HomePresenterType
    
    // MARK: View elements
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.newAutoLayout()
        return scrollView
    }()
    
    fileprivate lazy var infoView: InfoView = {
        let infoView = InfoView(
            viewModel: InfoViewModel(
                headerText: "Home View",
                descriptionText: "Feeling hungry for feature burgers.",
                imageName: "hamburgler",
                primaryButtonText: "Steal a burger"
            ),
            viewDelegate: self
        )
        return infoView
    }()
    
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
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.infoView)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        super.updateViewConstraints()
    }
}

// MARK: InfoViewDelegate
extension HomeViewController: InfoViewDelegate {
    func handlePrimaryAction(_ infoView: InfoViewType) {
        self.presenter.handlePrimaryAction(self)
    }
}

// MARK: HomePresenterViewType
extension HomeViewController: HomePresenterViewType {
    
}
