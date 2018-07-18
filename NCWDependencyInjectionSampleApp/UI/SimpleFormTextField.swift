//
//  SimpleFormTextField.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/17/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

final class SimpleFormTextField: UITextField {
    
    private let insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, self.insets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, self.insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, self.insets)
    }
}
