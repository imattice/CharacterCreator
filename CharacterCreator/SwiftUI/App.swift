//
//  SourceApp.swift
//  Shared
//
//  Created by Ike Mattice on 4/13/21.
//

import SwiftUI

@main
struct SourceApp: App {
    @Environment(\.scenePhase) var scenePhase
    let dataStack = CoreDataStack.shared
    
    init() {
        loadDataFromJSON()
    }
    
    var body: some Scene {
        WindowGroup {
            CompendiumView()
                .environment(\.managedObjectContext, dataStack.context)
        }
        .onChange(of: scenePhase) { _ in
            dataStack.save()
        }
    }
    
    func loadDataFromJSON() {
        do {
            try RaceRecord.save()
            try SubraceRecord.save()
            try ClassRecord.save()
            try SubclassRecord.save()
            try BackgroundRecord.save()
            try FeatRecord.save()
            try LanguageRecord.save()
            try ItemRecord.save()
            try WeaponRecord.save()
            try ArmorRecord.save()
            try ShieldRecord.save()
            try PackRecord.save()
            try ToolRecord.save()
            try SpellRecord.save()
            try MagicItemRecord.save()
            try RuleRecord.save()
            try ConditionRecord.save()
            try DiseaseRecord.save()
            try PoisonRecord.save()
            try TrapRecord.save()
            try CreatureRecord.save()
        }
        catch {
            print(error)
        }
    }
}
