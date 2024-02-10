//
//  CoreDataBootcamp.swift
//  CoreDataMVVM
//
//  Created by radu on 10.02.2024.
//
import SwiftUI

struct ContactsListView: View {
    @EnvironmentObject var model: Model
    
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
                    
                    ForEach(Array(model.contacts.indices), id: \.self) { index in
                        let contact = model.contacts[index]
                        HStack {
                            ContactRemoteImage(name:contact.name ,idx:Int(contact.id)  )
                            
                            Text(contact.name)
                                .font(.title)
                        }
                        .frame(height: 64)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .task {
                model.getContacts()
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
    ContactsListView().environmentObject(Model.shared)
}





