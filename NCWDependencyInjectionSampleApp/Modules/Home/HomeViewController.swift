//
//  HomeViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Models
protocol HomeViewModelType {
    var infoViewModel: InfoViewModelType { get set }
}

struct HomeViewModel: HomeViewModelType {
    var infoViewModel: InfoViewModelType
}

// MARK: Inbound protocol interface
protocol HomeViewControllerType: class {
    
}

final class HomeViewController: UIViewController, HomeViewControllerType {
    
    let presenter: HomePresenterType
    let viewModel: HomeViewModelType
    
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
            viewModel: self.viewModel.infoViewModel,
            viewDelegate: self
        )
        return infoView
    }()
    
    // MARK: Initializers
    
    init(presenter: HomePresenterType, viewModel: HomeViewModelType) {
        self.presenter = presenter
        self.viewModel = viewModel
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
