//
//  File.swift
//  Pago
//
//  Created by radu on 10.02.2024.
//

import Foundation
import CoreData

struct Contact: Decodable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String

}

import SwiftUI

@MainActor final class Model: ObservableObject {
    
    @Published var contacts: [Contact] = []
    var httpClient: NetworkCallManager = NetworkCallManager.shared
    static let shared = Model()
    
    let container:NSPersistentContainer
    @Published var savedEntities:[ContactEntity] = []
    
    private init() {
        self.httpClient = NetworkCallManager.shared
        container = NSPersistentContainer(name:"ContactsContainer")
        container.loadPersistentStores { (description, error ) in
            if let error = error {
                print ("ERROR LOADING CODE DATA \(error)")
            }
            else {
                
                print("🟩")
            }
        }
    }

    func getContacts() {
        //only grab the JSON if there are 0 contacts stored in core data
        if(savedEntities.count == 0) {
            Task {
                do {
                    contacts = try await NetworkCallManager.shared.getContactsFromURL()
                    saveContactsToCoreData(contacts)
                } catch {
                    fatalError("Cannot get contacts")
                }
            }
        }
        else{
            print("🟪",savedEntities.count)
        }
    }
    
    
    func saveContactsToCoreData(_ contacts: [Contact]) {
           
            for contact in contacts {
                
                let contactEntity = ContactEntity(context: container.viewContext)
                contactEntity.id = Int32(contact.id)
                contactEntity.name = contact.name
                contactEntity.email = contact.email
                contactEntity.gender = contact.gender
                contactEntity.status = contact.status
                saveData()
                print("Save 🟨" ,contactEntity.name ?? "no name", contactEntity.id)
            }
        }
    
    func saveData(){
        do {
            try  container.viewContext.save()
            fetchContact()
        }
        catch let error {
            print ("Error saving \(error)" )
        }
    }
    
    func fetchContact(){
        
        let request = NSFetchRequest<ContactEntity>(entityName: "ContactEntity")
        do{
           savedEntities  =  try container.viewContext.fetch(request)
        }catch let error {
            print ("Error fetching \(error)")
        }
    }

    
}


