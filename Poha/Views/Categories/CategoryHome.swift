//
//  CategoryHome.swift
//  Poha
//
//  Created by Wonhyuk Choi on 2022/09/01.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List {
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("포항 랜드마크")
            .toolbar {
                NavigationLink {
                    SelectionView()
                } label: {
                    Label("Recognize Landmark", systemImage: "camera.viewfinder")
                }
                .foregroundColor(Color("PrimaryColor"))
            }
        }
        .accentColor((colorScheme == .dark ? Color.white : Color.black).opacity(0.5))
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
