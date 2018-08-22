//
//  TabBarItem1ViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: View controller interface
protocol TabBarItem1ViewControllerType: class {
    
}

final class TabBarItem1ViewController:
    UIViewController,
    TabBarItem1ViewControllerType,
    TabBarItem1PresenterToViewType {
    
    private let presenter: TabBarItem1PresenterType
    
    // MARK: View elements
    
    private lazy var infoView: InfoView = {
        let infoView = InfoView(
            viewModel: InfoViewModel(
                headerText: TabBarItem1Localization.InfoView.headerText,
                descriptionText: TabBarItem1Localization.InfoView.descriptionText,
                imageName: "hamburgler",
                primaryButtonText: TabBarItem1Localization.InfoView.primaryButtonText
            ),
            viewDelegate: self
        )
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    private var didSetConstraints: Bool = false

    // MARK: Initializers
    
    required init(presenter: TabBarItem1PresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        self.title = TabBarItem1Localization.tabBarItemText
        self.tabBarItem = UITabBarItem(
            title: TabBarItem1Localization.tabBarItemText,
            image: UIImage(named: "icon_moon"),
            tag: 0
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        // add views here
        self.view.addSubview(self.infoView)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        if !self.didSetConstraints {
            self.didSetConstraints = true
            
            NSLayoutConstraint.activate([
                self.infoView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 40),
                self.infoView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
                self.infoView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor)
            ])
        }
        super.updateViewConstraints()
    }
}

// MARK: InfoViewDelegate
extension TabBarItem1ViewController: InfoViewDelegate {
    func handlePrimaryAction(_ infoView: InfoViewType) {
        print("TODO hook up to presenter")
    }
}
