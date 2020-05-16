//
//  RealmProvider.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/20/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

protocol Record {
	var id: String { get set }
	var name: String { get set }
	var detail: String { get set }
//
//	static func allRecords(in realm: Realm) -> Results<Object>
//	static func record(for name: String, in realm: Realm) -> Object?
}




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
	//Spells
	public static var spellRecords: RealmProvider = {
		return RealmProvider(configuration: spellConfig)	}()
	private static let spellConfig = Realm.Configuration(fileURL: Bundle.main.url(forResource: "SpellRecords", withExtension: "realm" ),
														readOnly: true,
														schemaVersion: 10,
														objectTypes: [SpellRecord.self])
	//Backgrounds
	public static var backgroundRecords: RealmProvider = {
		return RealmProvider(configuration: backgroundConfig)	}()
	private static let backgroundConfig = Realm.Configuration(fileURL: Bundle.main.url(forResource: "BackgroundRecords", withExtension: "realm" ),
														readOnly: true,
														schemaVersion: 12,
														objectTypes: [BackgroundRecord.self])
}
