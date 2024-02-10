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
    
    private init() {
        self.httpClient = NetworkCallManager.shared
    }

    func getContacts() {
        Task {
            contacts = try await NetworkCallManager.shared.getContactsFromURL()
        }
    }

    
}


