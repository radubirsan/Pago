//
//  CoreDataBootcamp.swift
//  CoreDataMVVM
//
//  Created by radu on 10.02.2024.
//
import SwiftUI

struct ContactsListView: View {
    let headerTextColor = #colorLiteral(red: 0.5960641503, green: 0.6470625997, blue: 0.7450918555, alpha: 1)
    let headerBackgroundColor = #colorLiteral(red: 0.9372519851, green: 0.9490204453, blue: 0.9686259627, alpha: 1)
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                Section() {
                    HStack() {
                        Text("CONTACTELE MELE")
                      .bold()
                      Spacer()
                    }
                    .padding()
                    .foregroundColor(Color(headerTextColor))
                    .background(Color(headerBackgroundColor))
                    
                }
                List {
                    
                    ForEach(0..<11) { index in
                        HStack {
                            ContactRemoteImage(name:"Nume Prenume", idx:index)
                            Text ("Nume Prenume")
                        }
                    }
                   
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Contacte")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color.white)
        }
       
    }
}

#Preview {
    ContactsListView()
}





