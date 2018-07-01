//
//  UITraitCollection+NCW.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/24/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

extension UITraitCollection {
    
    /// Computes where current trait collection is of regular/regular size class.
    var isRegularRegularSizeClass: Bool {
        return self.horizontalSizeClass == .regular && self.verticalSizeClass == .regular
    }
    
    /// Computes where current trait collection is of compact/regular size class.
    var isCompactRegularSizeClass: Bool {
        return self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular
    }
    
    /// Computes where current trait collection is of regular/compact size class.
    var isRegularCompactSizeClass: Bool {
        return self.horizontalSizeClass == .regular && self.verticalSizeClass == .compact
    }
}
