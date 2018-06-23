//
//  DetailRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

// MARK: Protocols


protocol DetailRouterType: RouteType {
    
    // retain strong
    var presenter: DetailPresenterType! { get set }
}

// MARK: Classes

final class DetailRouter: DetailRouterType {
    
    var routeProvider: RouteProviderType?
    var presenter: DetailPresenterType!
    
    func routeTo<T: RouteType>(from: T?) {
        
    }
}
