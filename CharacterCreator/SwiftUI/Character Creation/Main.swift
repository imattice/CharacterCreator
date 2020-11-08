//
//  Main.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/8/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

@main
struct TestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RaceSelectionView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                NewRelic.start(withApplicationToken:"AAc5cd5fead1df73542320108549cfe7ac5f75a1cc")
        return true
    }
}
