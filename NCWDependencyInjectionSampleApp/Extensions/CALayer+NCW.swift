//
//  CALayer+NCW.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/2/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

extension CALayer {
    
    /// Will apply common form field style.
    func applyFormFieldStyle() {
        self.borderColor = UIColor.gray.cgColor
        self.borderWidth = 1
        self.cornerRadius = 5
    }
}
