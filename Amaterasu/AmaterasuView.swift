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
    }
}

struct Amaterasu_Previews: PreviewProvider {
    static var previews: some View {
        AmaterasuView()
    }
}
