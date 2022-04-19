//
//  HelperApp.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI

@main
struct HelperApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
