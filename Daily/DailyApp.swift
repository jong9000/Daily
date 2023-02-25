//
//  DailyApp.swift
//  Daily
//
//  Created by Jonathan Gentry on 2/25/23.
//

import SwiftUI

@main
struct DailyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
