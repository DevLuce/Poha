//
//  ContentView.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        CategoryHome()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
