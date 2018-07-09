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


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}
}

//globals
enum DataType: String { case `class`, race }

