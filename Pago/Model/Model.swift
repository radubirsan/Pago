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
                self.fetchContact()
                print("🟩", self.savedEntities.count)
                //This is just a way to clear the CoreData for tests
                //self.deleteAll()
                //self.saveData()
            }
        }
    }

    func getContacts() {
        //only grab the JSON if there are 0 contacts stored in coredata
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
    
    func deleteAll() {
          let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = ContactEntity.fetchRequest()
          let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
          _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
    
    func fetchContact(){
        
        let request = NSFetchRequest<ContactEntity>(entityName: "ContactEntity")
        do{
           savedEntities  =  try container.viewContext.fetch(request)
        }catch let error {
            print ("Error fetching \(error)")
        }
    }
    
    func addContact(text:String, id:Int, prenume:String = "", _ email:String = "") {
        let newContact = ContactEntity(context: container.viewContext)
        newContact.name = text //+ " \(id)"
        newContact.id = Int32(id)
        newContact.email  = email
        saveData()
    }
    
    func updateContact(entity:ContactEntity){
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteContact(indexSet:IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
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
}


