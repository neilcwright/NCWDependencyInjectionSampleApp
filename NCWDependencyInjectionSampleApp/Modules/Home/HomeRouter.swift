//
//  HomeRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

protocol HomeRouterType: RouteType {
    
    // retain strong
    var presenter: HomePresenterType! { get set }
}

final class HomeRouter: HomeRouterType {
    
    var presenter: HomePresenterType!
    
    func routeTo<T: RouteType>(from: T?) {
        
    }
}
