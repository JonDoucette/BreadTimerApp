//
//  ContentView.swift
//  BreadTimer
//
//  Created by Jon Doucette on 12/27/23.
//

// Combine Ingredients, Fold and Shape x times every x minutes
//Bulk Fermentation
// Shaping
// Proof (second Rest)
// Preheat Oven
// Put in oven
// Take out of oven and let rest
// Completed

import SwiftUI



struct ContentView: View {
    var body: some View {
        TabView {
//            BakeView()
//                .tabItem { Label("Breads", systemImage: "list.bullet.circle") }
            BakeView()
                .tabItem {
                    Label("Bake", systemImage: "oven")
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear.circle")
                }
        }.toolbarColorScheme(.light, for: .tabBar)
            .accentColor(.black)

        
    }

}
    
#Preview {
    ContentView()
}
