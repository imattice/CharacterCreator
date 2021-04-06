//
//  AppDelegate.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		return true
	}
    
}

//globals
enum DataType: String { case `class`, race }

func delay(seconds: Double, completion: @escaping ()-> Void) {
	DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

func print(title: String, attribute: Any) {
	print("\(title): \(attribute)")
}
func print(title: String, attributes: [Any]) {
	print("-\(title)-")
	for attribute in attributes {
		print(attribute)
	}
	print("---")
}
