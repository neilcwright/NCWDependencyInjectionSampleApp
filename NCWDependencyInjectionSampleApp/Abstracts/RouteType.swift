//
//  RouteType.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/23/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//
import UIKit

/// Generic route type protocol that all routers conform to.
protocol RouteType: class {

    // The wireframe object allows routers to access other routers at runtime.
    // (should be held weakly by conforming class)
    var wireframe: WireframeType? { get set }
    
    /// Will hold the presented view controller of a given route.
    var presentedViewController: UIViewController? { get set }
}
