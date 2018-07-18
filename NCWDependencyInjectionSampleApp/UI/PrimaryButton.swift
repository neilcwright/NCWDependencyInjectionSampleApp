//
//  PrimaryButton.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Protocols

protocol PrimaryButtonModelType {
    
    /// The corner radius to be applied to a button instance that this model backs
    var cornerRadius: CGFloat { get set }
    
    /// The inset value to use to the leading and trailing (left/right) edges of text w/n button instance
    var horizontalInset: CGFloat { get set }
    
    /// The inset value to use for the top and bottom edges of text w/n button instance
    var verticalInset: CGFloat { get set }
}

struct PrimaryButtonViewModel: PrimaryButtonModelType {
    var cornerRadius: CGFloat
    var horizontalInset: CGFloat
    var verticalInset: CGFloat
}

protocol PrimaryButtonDelegate: class {
    
    /// Will delegate the tap event for primary button instance.
    /// If there are more than one instance in a given view, set the accessibility id on button and
    /// switch handling based on the button's accessibility id.
    ///
    /// - Parameter button: button instance that triggered event.
    func handleTapEvent<T: PrimaryButtonType & UIButton>(fromPrimaryButton button: T)
}

protocol PrimaryButtonType {}

// MARK: Classes

final class PrimaryButton: UIButton, PrimaryButtonType {
    
    fileprivate let viewModel: PrimaryButtonModelType
    fileprivate weak var delegate: PrimaryButtonDelegate?
    
    // MARK: Initializers
    
    required init(viewModel: PrimaryButtonModelType, delegate: PrimaryButtonDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(handleTapEvent), for: .touchUpInside)
        self.layer.cornerRadius = viewModel.cornerRadius
        self.applyStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIButton
    
    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: super.intrinsicContentSize.width + (self.viewModel.horizontalInset * 2),
            height: super.intrinsicContentSize.height + (self.viewModel.verticalInset * 2)
        )
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.titleLabel?.font = UIFont.preferredFont(
            forTextStyle: .body,
            compatibleWith: self.traitCollection
        )
        self.invalidateIntrinsicContentSize()
    }
    
    @objc func handleTapEvent() {
        self.delegate?.handleTapEvent(fromPrimaryButton: self)
    }
    
    private func applyStyle() {
        self.backgroundColor = UIColor.black
    }
}

