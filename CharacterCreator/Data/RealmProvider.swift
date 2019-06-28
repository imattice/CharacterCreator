//
//  RealmProvider.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/20/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmProvider {
	let configuration: Realm.Configuration
	var realm: Realm {
		return try! Realm(configuration: configuration)	}


	//Languages
	public static var languageRecords: RealmProvider = {
		return RealmProvider(configuration: languageConfig)	}()
	private static let languageConfig = Realm.Configuration(fileURL: Bundle.main.url(forResource: "LanguageRecords", withExtension: "realm" ),
															readOnly: true,
															schemaVersion: 1,
															objectTypes: [LanguageRecord.self])
	//Items
	public static var itemRecords: RealmProvider = {
		return RealmProvider(configuration: itemConfig)	}()
	private static let itemConfig = Realm.Configuration(fileURL: Bundle.main.url(forResource: "ItemRecords", withExtension: "realm" ),
														readOnly: true,
														schemaVersion: 25,
														objectTypes: [ItemRecord.self,
																	  WeaponRecord.self,
																	  ArmorRecord.self,
																	  PackRecord.self])
}
