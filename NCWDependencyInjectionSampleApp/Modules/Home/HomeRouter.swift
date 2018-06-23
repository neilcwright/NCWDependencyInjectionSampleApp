//
//  HomeRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

protocol HomeRouterType: RouteType, HomePresenterRouterType {
    
    // retain strong
    var presenter: HomePresenterType! { get set }
    
    // MARK: HomePresenterRouterType
    
} 

final class HomeRouter: HomeRouterType {
    
    var routeProvider: RouteProviderType?
    var presenter: HomePresenterType!
    
    func routeTo<T: RouteType>(from: T?) {
        
    }
}
