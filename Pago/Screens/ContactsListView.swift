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
                        Text("CONTACTELE MELE (\(model.savedEntities.count))")
                      .bold()
                      Spacer()
                    }
                    .padding()
                    .foregroundColor(Color(headerTextColor))
                    .background(Color(headerBackgroundColor))
                    
                }
                List {
                    ForEach(Array(model.savedEntities.indices), id: \.self) { index in
                        let entity = model.savedEntities[index]
                        HStack {
                            if let unwraped = entity.name {
                                ContactRemoteImage(name:unwraped ,idx:Int(entity.id)  )
                            }
                            Text(entity.name ?? "No Name")
                                .font(.title)
                        }
                        .frame(height: 64)
                    }
                    .onDelete(perform: { indexSet in
                        model.deleteContact(indexSet: indexSet)
                    })
                    
                }
                .listStyle(PlainListStyle())
            }
            .task{
                model.getContacts()
            }
            .navigationTitle("Contacte")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Edit button was tapped")
                        model.addContact(text: "Contact", id:Int.random(in: 1...10000))
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(headerTextColor))
                            .padding(7)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(headerTextColor), lineWidth: 2)
                            )
                    }
                    
                }
                
            }
            .background(Color.white)
        }
       
    }
}

#Preview {
    ContactsListView().environmentObject(Model.shared)
}





