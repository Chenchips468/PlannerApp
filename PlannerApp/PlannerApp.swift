//
//  PlannerAppApp.swift
//  PlannerApp
//
//  Created by William Chen on 8/16/26.
//

import SwiftUI
import SwiftData

@main
struct PlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for:[Record.self, PlannerTask.self])
    }
}
