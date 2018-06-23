//
//  RouteProvider.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/23/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject

// MARK: Protocols

protocol RouteProviderType: class {
    
    /// Handle to our assembler for resolving dependencies within container.
    var assembler: Assembler! { get set }
    
    /// Property injection method so our route provider shared instance has access to our assembler
    /// for container resolution of dependencies. This will set `assembler` property and hold it strongly.
    ///
    /// - Parameter assembler: the assembler to which we'll resolve our dependencies within container.
    func setAssembler(_ assembler: Assembler)
    
    /// When called will route to a route type and return it so that we can call our methods from
    /// any other route in application.
    ///
    /// - Returns: a new route type instance, resolved from the provider's assembler container.
    func routeTo<T>(_ route: T.Type) -> T?
}

class RouteProvider: RouteProviderType {
    
    // MARK: Auto-wired
    
    var assembler: Assembler!
    
    // MARK: RouteProviderType

    func routeTo<T>(_ route: T.Type) -> T? {
        if let routeAtUrl = self.assembler.resolver.resolve(route) {
            return routeAtUrl
        }
        assertionFailure("was unable to find route at specified url")
        return nil
    }
    
    func setAssembler(_ assembler: Assembler) {
        self.assembler = assembler
    }
}
