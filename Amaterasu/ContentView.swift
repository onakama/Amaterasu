//
//  ContentView.swift
//  Amaterasu
//
//  Created by nekuro on 2021/07/27.
//

import SwiftUI
import YumemiWeather
import Foundation

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    @Environment(\.presentationMode) var presentation
    init(){
        print("contentView")
    }
    var body: some View {
        VStack{
            Image(viewModel.weatherIcon)
                .resizable()
                .foregroundColor(viewModel.weatherColor)
                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
            HStack{
                Text(String(viewModel.minTemp))
                    .frame(width: UIScreen.main.bounds.width/4)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text(String(viewModel.maxTemp))
                    .frame(width: UIScreen.main.bounds.width/4)
                    .foregroundColor(.red)
            }
            .overlay(viewModel.isLoading ? ProgressView("Loading"): nil)
            HStack{
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Close")
                }
                    .frame(width: UIScreen.main.bounds.width/4)
                Button(action: {
                    viewModel.changeWeather()
                }) {
                    Text("Reload")
                }
    
                .frame(width: UIScreen.main.bounds.width/4)
                .alert(isPresented: $viewModel.isError, content: {
                    Alert(title: Text("アラート"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK"),action: {}))
                })
            }
            .padding(.top, 80)
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("scenePhase"))) { ScenePhase in
            viewModel.changeWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
