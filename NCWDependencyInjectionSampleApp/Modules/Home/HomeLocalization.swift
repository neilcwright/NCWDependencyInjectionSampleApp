//
//  HomeLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/24/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

fileprivate let tableName = "Home"
struct HomeLocalization {
    
    /// The home view's localization
    static var titleText: String {
        return "home.view.title.text".localized(tableName: tableName)
    }
    
    static var descriptionText: String {
        return "home.view.description.text".localized(tableName: tableName)
    }
    
    static var primaryButtonText: String {
        return "home.view.primary.button.text".localized(tableName: tableName)
    }
}
