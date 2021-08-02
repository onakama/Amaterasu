//
//  AmaterasuApp.swift
//  Amaterasu
//
//  Created by nekuro on 2021/07/27.
//

import SwiftUI

@main
struct AmaterasuApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            AmaterasuView()
        }
        .onChange(of: scenePhase, perform: { phase in
            if phase == .active{
                NotificationCenter.default.post(name: Notification.Name("scenePhase"),object: phase)
            }
        })
        
    }
}
