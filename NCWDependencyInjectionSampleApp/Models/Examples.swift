//
//  Examples.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

protocol Example {
    var thing: String { get }
    
    func setThing(_ thing: String)
}

protocol Foo: Example, CustomStringConvertible {
    
}

protocol Bar: Example, CustomStringConvertible {
    
}

class FooThing: Foo, CustomStringConvertible {
    var thing: String
    
    init(thing: String) {
        self.thing = thing
    }
    
    var description: String {
        return "\(self.thing)"
    }
    
    func setThing(_ thing: String) {
        self.thing = thing
    }
}

class BarThing: Bar, CustomStringConvertible {
    var thing: String
    
    init(thing: String) {
        self.thing = thing
    }
    
    var description: String {
        return "\(self.thing)"
    }
    
    func setThing(_ thing: String) {
        self.thing = thing
    }
}
