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
    
    var body: some Scene {
        WindowGroup {
            CompendiumView()
                .environment(\.managedObjectContext, dataStack.context)
        }
        .onChange(of: scenePhase) { _ in
            dataStack.save()
        }
    }
}
