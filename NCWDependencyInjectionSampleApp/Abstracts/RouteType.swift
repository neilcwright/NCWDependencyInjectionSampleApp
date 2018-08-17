//
//  RouteType.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/23/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//
import UIKit

/// Generic route type protocol that all routers conform to.
/// Allows us to query route url on class directly w/o instance.
protocol RouteType: class {

    // hold weakly
    var wireframe: WireframeType? { get set }
    
    /// Will hold the presented view controller of a given route.
    var presentedViewController: UIViewController? { get set }
}
