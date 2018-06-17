//
//  PrimaryButton.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Protocols

protocol PrimaryButtonType {
    var delegate: PrimaryButtonDelegate? { get set }
}

protocol PrimaryButtonDelegate: class {
    func handleTapEvent<T: PrimaryButtonType>(fromPrimaryButton button: T)
}

// MARK: Classes

final class PrimaryButton: UIButton, PrimaryButtonType {
    weak var delegate: PrimaryButtonDelegate?
    
    // MARK: Initializers
    
    required init(delegate: PrimaryButtonDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        self.addTarget(self, action: #selector(handleTapEvent), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTapEvent() {
        self.delegate?.handleTapEvent(fromPrimaryButton: self)
    }
}

