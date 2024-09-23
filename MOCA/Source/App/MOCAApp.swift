//
//  MOCAApp.swift
//  MOCA
//
//  Created by 강석호 on 9/16/24.
//

import SwiftUI

@main
struct MOCAApp: App {
    
    @StateObject private var realmManager = MocaRealmManager()
    
    init() {
        setupRealmMigration()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(realmManager)
        }
    }
}
