//
//  TabBarItem1Localization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import Foundation

fileprivate let tableName = "TabBarItem1"
struct TabBarItem1Localization {

    static var tabBarItemText: String {
        return "tab.bar.item.1.title.text".localized(tableName: tableName)
    }
    
    struct InfoView: InfoViewLocalizable {
        static var headerText: String {
            return "tab.bar.item.1.info.view.header.text".localized(tableName: tableName)
        }
        
        static var descriptionText: String {
            return "tab.bar.item.1.info.view.description.text".localized(tableName: tableName)
        }
        
        static var primaryButtonText: String {
            return "tab.bar.item.1.info.view.primary.button.text".localized(tableName: tableName)
        }
    }
}
