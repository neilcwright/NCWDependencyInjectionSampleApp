//
//  TabBarItem3Localization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import Foundation

fileprivate let tableName = "TabBarItem3"
struct TabBarItem3Localization {
    
    // Example usage:
    static var tabBarItemText: String {
        return "tab.bar.item.3.title.text".localized(tableName: tableName)
    }
    
    // strings belonging to featured info view
    struct InfoView: InfoViewLocalizable {
        static var headerText: String {
            return "tab.bar.item.3.info.view.header.text".localized(tableName: tableName)
        }
        
        static var descriptionText: String {
            return "tab.bar.item.3.info.view.description.text".localized(tableName: tableName)
        }
        static var primaryButtonText: String {
            return "tab.bar.item.3.info.view.primary.button.text".localized(tableName: tableName)
        }
    }
}
