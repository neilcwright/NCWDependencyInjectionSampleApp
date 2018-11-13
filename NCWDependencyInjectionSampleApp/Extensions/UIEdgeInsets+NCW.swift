//
//  UIEdgeInsets+NCW.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 11/12/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
}
