//
//  N_TApp.swift
//  N&T
//
//  Created by Khushal Mandavia on 10/8/24.
//

import SwiftUI

@main
struct N_TApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
