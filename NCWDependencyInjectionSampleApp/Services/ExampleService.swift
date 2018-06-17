//
//  ExampleService.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

protocol ExampleServiceType: class {
    func getFoo(success: @escaping (_ foo: Foo) -> Void)
}

final class ExampleService: ExampleServiceType {
    
    func getFoo(success: @escaping (_ foo: Foo) -> Void) {
        
    }
}
