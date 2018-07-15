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
    var cornerRadius: CGFloat { get set }
    var horizontalInset: CGFloat { get set }
    var verticalInset: CGFloat { get set }
}

struct PrimaryButtonViewModel: PrimaryButtonModelType {
    var cornerRadius: CGFloat
    var horizontalInset: CGFloat
    var verticalInset: CGFloat
}

protocol PrimaryButtonDelegate: class {
    func handleTapEvent<T: PrimaryButtonType & UIButton>(fromPrimaryButton button: T)
}

protocol PrimaryButtonType {}

// MARK: Classes

final class PrimaryButton: UIButton, PrimaryButtonType {
    
    fileprivate let viewModel: PrimaryButtonViewModel
    fileprivate weak var delegate: PrimaryButtonDelegate?
    
    // MARK: Initializers
    
    required init(viewModel: PrimaryButtonViewModel, delegate: PrimaryButtonDelegate) {
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

