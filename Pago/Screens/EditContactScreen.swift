//
//  EditContactScreen.swift
//  Pago
//
//  Created by radu on 10.02.2024.
//

import SwiftUI

struct EditContactScreen: View {
    
    @EnvironmentObject var model: Model
    @State private var numeContact: String = ""
    @State private var prenumeContact: String = ""
    @State private var emailContact: String = ""
    @State private var telContact: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
          
                Form {
                    Section(header: Text("NUME")) {
                        FormItem(title: "NUME", text: $numeContact)
                    }
                    
                    Section(header: Text("PRENUME")) {
                        FormItem(title: "PRENUME", text: $prenumeContact)
                    }
                    
                    Section(header: Text("TELEFON")) {
                        FormItem(title: "TELEFON", text: $telContact)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("EMAIL")) {
                        FormItem(title: "EMAIL", text: $emailContact)
                    }
                    
                    Section {
                        } footer: {
                            VStack {
                                Spacer()
                                Button(action: {
                                    model.addContact(text: numeContact + " " + prenumeContact, id: Int.random(in: 1...10000))
                                }) {
                                    Text("Salvează")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.green)
                                        .cornerRadius(17)
                                        .foregroundColor(.white)
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                }
                                .contentShape(Rectangle())
                            }
                        }
                }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle("Adauga Contact")
        }
    }
}


struct FormItem: View {
    var title: String
    @Binding var text: String

    var body: some View {
        VStack {
            TextField("", text: $text)
                .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
                .font(.title2)
                .padding(.bottom, -12)
        }
        .frame(maxWidth: .infinity, minHeight: 40)
        .padding(.horizontal, 2)
    }
}

#Preview {
    EditContactScreen().environmentObject(Model.shared)
}
