//
//  Amaterasu.swift
//  Amaterasu
//
//  Created by nekuro on 2021/07/31.
//

import SwiftUI

struct AmaterasuView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State var isModal: Bool = true
    var body: some View {
        Button(""){
            self.isModal = true
        }
        .sheet(isPresented: $isModal,onDismiss:{isModal = true}) {
            ContentView()
        }
        .onChange(of: scenePhase, perform: { phase in
            if phase == .active{
                NotificationCenter.default.post(name: Notification.Name("scenePhase"),object: phase)
            }
        })
    }
}

struct Amaterasu_Previews: PreviewProvider {
    static var previews: some View {
        AmaterasuView()
    }
}
