//
//  GameOnApp.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

@main
struct GameOnApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
