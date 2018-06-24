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
    var imageName: String! { get set }
}

final class HomeViewController: UIViewController, HomeViewControllerType {
    
    let presenter: HomePresenterType
    var imageName: String!
    
    // MARK: View elements
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.newAutoLayout()
        return scrollView
    }()
    
    fileprivate lazy var scrollContentView: UIView = UIView.newAutoLayout()
    
    fileprivate lazy var closeButton: UIButton = {
        let closeButton = UIButton.newAutoLayout()
        closeButton.setImage(
            UIImage(named: "close"),
            for: UIControlState.normal
        )
        closeButton.addTarget(self, action: #selector(doCloseAction(_:)), for: .touchUpInside)
        return closeButton
    }()
    
    fileprivate lazy var infoView: InfoView = {
        let infoView = InfoView(
            viewModel: InfoViewModel(
                headerText: "Home View",
                descriptionText: "Feeling hungry for feature burgers.",
                imageName: self.imageName,
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
        self.view.addSubview(self.closeButton)
        self.scrollView.addSubview(self.scrollContentView)
        
        self.scrollContentView.addSubview(self.infoView)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        self.edgesForExtendedLayout = []
        self.scrollView.autoPinEdgesToSuperviewEdges()
        self.scrollContentView.autoCenterInSuperview()
        self.infoView.autoPinEdgesToSuperviewEdges()

        self.closeButton.autoPinEdge(.top, to: .top, of: self.view, withOffset: 30.0)
        self.closeButton.autoPinEdge(.trailing, to: .trailing, of: self.view, withOffset: -30.0)
        self.closeButton.autoSetDimensions(to: self.closeButton.intrinsicContentSize)
        super.updateViewConstraints()
    }
    
    // MARK: Selector methods
    
    @objc func doCloseAction(_ sender: AnyObject) {
        self.presenter.handleCloseAction(self)
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
