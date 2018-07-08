//
//  ErrorLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

import Foundation

fileprivate let tableName = "Error"

protocol ErrorLocalizable {
    static var headerText: String { get }
    static var descriptionText: String { get }
    static var primaryButtonText: String { get }
}

struct ErrorLocalization {

    struct Generic: ErrorLocalizable {
        static var headerText: String {
            return "error.view.general.header.text".localized(tableName: tableName)
        }
        static var descriptionText: String {
            return "error.view.general.description.text".localized(tableName: tableName)
        }
        static var primaryButtonText: String {
            return "error.view.general.primary.button.text".localized(tableName: tableName)
        }
    }
    
    struct InvalidLoginCredentials: ErrorLocalizable {
        static var headerText: String {
            return "error.view.invalid.login.credentials.header.text".localized(tableName: tableName)
        }
        static var descriptionText: String {
            return "error.view.invalid.login.credentials.description.text".localized(tableName: tableName)
        }
        static var primaryButtonText: String {
            return "error.view.invalid.login.credentials.primary.button.text".localized(tableName: tableName)
        }
    }
    
    struct NetworkUnavailable: ErrorLocalizable {
        static var headerText: String {
            return "error.view.network.unavailable.header.text".localized(tableName: tableName)
        }
        static var descriptionText: String {
            return "error.view.network.unavailable.description.text".localized(tableName: tableName)
        }
        static var primaryButtonText: String {
            return "error.view.network.unavailable.primary.button.text".localized(tableName: tableName)
        }
    }
}
