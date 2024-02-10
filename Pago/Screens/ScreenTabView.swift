//
//  ScreenTabView.swift
//  Pago
//
//  Created by radu on 10.02.2024.
//

import SwiftUI

struct ScreenTabView: View {

    var body: some View {
        TabView {
            ContactsListView()
                .environmentObject(Model.shared)
                .tabItem { Label("Contacte", systemImage: "person.crop.circle.fill") }
            
            EditContactScreen()
                .environmentObject(Model.shared)
                .tabItem { Label("Edit", systemImage: "person.fill.badge.plus") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTabView()
    }
}
