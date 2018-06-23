//
//  RouteType.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/23/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

/// Generic route type protocol that all routers conform to.
/// Allows us to query route url on class directly w/o instance.
protocol RouteType: class {
    
    /// The url of route.
    static var url: String { get }
    
    // hold weakly
    var routeProvider: RouteProviderType? { get set }
}

// MARK: - RouteType
extension RouteType {

    static var url: String {
        return String(describing: self)
    }
}
