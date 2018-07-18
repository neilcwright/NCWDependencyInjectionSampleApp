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
    
    fileprivate let presenter: DetailPresenterType
    fileprivate let infoViewModel: InfoViewModelType
    
    fileprivate lazy var infoView: InfoView = {
        let infoView = InfoView(
            viewModel: self.infoViewModel,
            viewDelegate: self
        )
        return infoView
    }()
    
    // MARK: Initializers
    
    required init(presenter: DetailPresenterType, infoViewModel: InfoViewModelType) {
        self.presenter = presenter
        self.infoViewModel = infoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle methods
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.infoView)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        self.infoView.autoCenterInSuperview()
        super.updateViewConstraints()
    }
}

// MARK: InfoViewDelegate
extension DetailViewController: InfoViewDelegate {
    func handlePrimaryAction(_ infoView: InfoViewType) {
        self.presenter.handlePrimaryAction()
    }
}
