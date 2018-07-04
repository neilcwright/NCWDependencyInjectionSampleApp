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
    
    /// Will resolve and return an instance of type from assembler's container
    /// if type has been registered; `nil` otherwise.
    ///
    /// - Parameter type: the type to resolve and return instance of.
    /// - Returns: an instance of type if one is registered; `nil` otherwise.
    func resolve<T>(_ type: T.Type) -> T?
    
    /// When called will route to a route type and return it so that we can call our methods from
    /// any other route in application.
    ///
    /// - Returns: a new route type instance, resolved from the provider's assembler container.
    func route<T>(_ route: T.Type) -> T?
}

class RouteProvider: RouteProviderType {
    
    // MARK: Auto-wired
    
    var assembler: Assembler!
        
    // MARK: RouteProviderType

    func route<T>(_ route: T.Type) -> T? {
        if let routeAtUrl = self.assembler.resolver.resolve(route) {
            return routeAtUrl
        }
        assertionFailure("was unable to find route at specified url")
        return nil
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        return self.assembler.resolver.resolve(T.self)
    }
    
    func setAssembler(_ assembler: Assembler) {
        self.assembler = assembler
    }
}
