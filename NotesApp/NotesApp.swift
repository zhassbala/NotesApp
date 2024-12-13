//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Rassul Bessimbekov on 13.12.2024.
//

import SwiftUI
import SwiftData

// @main is similar to the entry point in a React app (like index.js)
@main
struct NotesApp: App {
    // Similar to creating a Redux store or database connection
    let container: ModelContainer
    
    // Similar to initializing your app's state management
    // Like setting up Redux store or React Query client
    init() {
        do {
            let schema = Schema([Note.self])
            let modelConfiguration = ModelConfiguration(schema: schema)
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not initialize SwiftData container: \(error)")
        }
    }
    
    // Similar to the root component in React
    var body: some Scene {
        // WindowGroup is like your app's root container
        WindowGroup {
            ContentView()
        }
        // Similar to wrapping your app in Redux Provider or Context Provider
        .modelContainer(container)
    }
}
