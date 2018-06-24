//
//  AppDelegate.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/15/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit
import Swinject
import SwinjectPropertyLoader

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    fileprivate var routeProvider: RouteProviderType?
    var rootRouter: RootRouterType?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            // load properties from json files
            let assembler = try Assembler(assemblies: [
                ProviderAssembly(),
                ModelAssembly(),
                HomeAssembly(),
                DetailAssembly(),
                RootAssembly(),
                ServiceAssembly()
            ])
            
            // load up properties
            try assembler.applyPropertyLoader(
                JsonPropertyLoader(
                    bundle: Bundle.main,
                    name: "properties"
                )
            )
            
            self.routeProvider = assembler.resolver.resolve(RouteProviderType.self)
            self.routeProvider?.setAssembler(assembler)
            
            self.rootRouter = self.routeProvider?.route(RootRouterType.self)
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = self.rootRouter?.loadView(in: window)
            self.window?.makeKeyAndVisible()
        } catch {
            print("unable to load properties")
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
