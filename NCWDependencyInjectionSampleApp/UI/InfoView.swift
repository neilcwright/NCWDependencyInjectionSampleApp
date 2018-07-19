//
//  InfoView.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/23/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

/// Localization protocol for module views featuring info view instances localization objects to conform to
protocol InfoViewLocalizable {
    static var headerText: String { get }
    static var descriptionText: String { get }
    static var primaryButtonText: String { get }
}

/// Model protocol for an info view.
protocol InfoViewModelType {
    var headerText: String { get set }
    var descriptionText: String { get set }
    var imageName: String { get set }
    var primaryButtonText: String { get set }
}

struct InfoViewModel: InfoViewModelType {
    var headerText: String
    var descriptionText: String
    var imageName: String
    var primaryButtonText: String
}

protocol InfoViewType {
    
}

protocol InfoViewDelegate: class {
    
    /// Will handle the info view's primary action event.
    ///
    /// - Parameter infoView: view instance where event originates from
    func handlePrimaryAction(_ infoView: InfoViewType)
}

final class InfoView: UIView, InfoViewType {
    
    fileprivate let viewModel: InfoViewModelType
    fileprivate weak var viewDelegate: InfoViewDelegate?
    
    // MARK: View elements
    
    fileprivate lazy var headerLabel: UILabel = {
        let headerLabel = UILabel.newAutoLayout()
        headerLabel.text = self.viewModel.headerText
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title1, compatibleWith: self.traitCollection)
        headerLabel.textColor = .black
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.textAlignment = .center
        return headerLabel
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel.newAutoLayout()
        descriptionLabel.text = self.viewModel.descriptionText
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: self.traitCollection)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        return descriptionLabel
    }()
    
    fileprivate lazy var heroView: UIImageView = {
        let heroView = UIImageView.newAutoLayout()
        heroView.image = UIImage(named: self.viewModel.imageName)
        return heroView
    }()
    
    fileprivate lazy var primaryButton: PrimaryButton = {
        let primaryButton = PrimaryButton(
            viewModel: PrimaryButtonViewModel(
                cornerRadius: 5.0,
                horizontalInset: 20.0,
                verticalInset: 10.0
            ),
            delegate: self
        )
        primaryButton.setTitle(self.viewModel.primaryButtonText, for: UIControlState())
        return primaryButton
    }()
    
    // MARK: Initializers
    
    init(viewModel: InfoViewModelType, viewDelegate: InfoViewDelegate) {
        self.viewModel = viewModel
        self.viewDelegate = viewDelegate
        
        super.init(frame: .zero)
        
        self.addSubview(self.headerLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.heroView)
        self.addSubview(self.primaryButton)
        
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIView
    
    override func updateConstraints() {
        self.headerLabel.autoPinEdge(toSuperviewEdge: .top)
        self.headerLabel.autoConstrainAttribute(.width, to: .width, of: self, withMultiplier: 8/10)
        self.headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.descriptionLabel.autoPinEdge(.top, to: .bottom, of: self.headerLabel, withOffset: 10)
        self.descriptionLabel.autoConstrainAttribute(.width, to: .width, of: self.headerLabel)
        self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.heroView.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: 20)
        self.heroView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.primaryButton.autoPinEdge(.top, to: .bottom, of: self.heroView, withOffset: 20)
        self.primaryButton.autoConstrainAttribute(.width, to: .width, of: self.heroView)
        self.primaryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.primaryButton.autoPinEdge(toSuperviewEdge: .bottom)
        
        super.updateConstraints()
    }
}

// MARK: PrimaryButtonDelegate
extension InfoView: PrimaryButtonDelegate {
    func handleTapEvent<T: PrimaryButtonType>(fromPrimaryButton button: T) {
        self.viewDelegate?.handlePrimaryAction(self)
    }
}
