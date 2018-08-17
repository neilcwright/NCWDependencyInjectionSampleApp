//
//  TabBarItem3ViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: View controller interface
protocol TabBarItem3ViewControllerType: class {
    
}

final class TabBarItem3ViewController:
    UIViewController,
    TabBarItem3ViewControllerType,
    TabBarItem3PresenterToViewType {
    
    let presenter: TabBarItem3PresenterType
    
    private var didSetConstraints: Bool = false
    
    // MARK: View elements
    
    private lazy var infoView: InfoView = {
        let infoView = InfoView(
            viewModel: InfoViewModel(
                headerText: TabBarItem3Localization.InfoView.headerText,
                descriptionText: TabBarItem3Localization.InfoView.descriptionText,
                imageName: "dude",
                primaryButtonText: TabBarItem3Localization.InfoView.primaryButtonText
            ),
            viewDelegate: self
        )
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()

    // MARK: Initializers
    
    required init(presenter: TabBarItem3PresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        self.title = TabBarItem3Localization.tabBarItemText
        self.tabBarItem = UITabBarItem(
            title: TabBarItem3Localization.tabBarItemText,
            image: UIImage(named: "icon_cloudy"), // TODO add a different icon
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
        // apply constraints here
        
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
extension TabBarItem3ViewController: InfoViewDelegate {
    func handlePrimaryAction(_ infoView: InfoViewType) {
        self.presenter.handlePrimaryAction()
    }
}
