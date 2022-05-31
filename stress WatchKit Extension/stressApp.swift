//
//  stressApp.swift
//  stress WatchKit Extension
//
//  Created by Martin Nanchev on 31.05.22.
//

import SwiftUI

@main
struct stressApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
