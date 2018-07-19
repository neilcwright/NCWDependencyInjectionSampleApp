//
//  TabBarItem2ViewController.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: View controller interface
protocol TabBarItem2ViewControllerType: class {
    
}

final class TabBarItem2ViewController:
    UIViewController,
    TabBarItem2ViewControllerType,
    TabBarItem2PresenterToViewType {
    
    let presenter: TabBarItem2PresenterType
    private var didSetConstraints: Bool = false
    
    // MARK: View elements
    
    private lazy var infoView: InfoView = {
        let infoView = InfoView(
            viewModel: InfoViewModel(
               headerText: TabBarItem2Localization.InfoView.headerText,
               descriptionText: TabBarItem2Localization.InfoView.descriptionText,
               imageName: "dude",
               primaryButtonText: TabBarItem2Localization.InfoView.primaryButtonText
            ),
            viewDelegate: self
        )
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()

    // MARK: Initializers
    
    required init(presenter: TabBarItem2PresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        self.title = TabBarItem2Localization.tabBarItemText
        self.tabBarItem = UITabBarItem(
            title: TabBarItem2Localization.tabBarItemText,
            image: UIImage(named: "icon_cloudy"),
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
extension TabBarItem2ViewController: InfoViewDelegate {
    func handlePrimaryAction(_ infoView: InfoViewType) {
        print("TODO hook up to presenter")
    }
}
