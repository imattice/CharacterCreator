//
//  AppDelegate.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		NewRelic.start(withApplicationToken:"AAc5cd5fead1df73542320108549cfe7ac5f75a1cc")

		return true
	}
}

//globals
enum DataType: String { case `class`, race }

func delay(seconds: Double, completion: @escaping ()-> Void) {
	DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

func sayHi(_ message: String = "hi") {
	print(message)
}
