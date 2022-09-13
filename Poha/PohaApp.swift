//
//  PohaApp.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

@main
struct PohaApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
