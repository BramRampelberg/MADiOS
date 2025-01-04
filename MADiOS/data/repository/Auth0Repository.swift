//
//  Auth0Repository.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import Auth0
import CoreData

class Auth0Repository {
    private let credentialsManager = Auth0Manager.manager.credentialsManager
    private let auth0Service = Auth0Service()
    
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    private let sharedCoreDataStack = CoreDataStack.shared
    
    func login(email: String, password: String) async -> Bool {
        do {
            let credentials = try await auth0Service.login(email: email, password: password)
            return credentialsManager.store(credentials: credentials)
        }
        catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func logout() -> Bool {
        let success = credentialsManager.clear()
        if success {
            clearLocalDatabase()
            return success
        }
        return false
    }
    
    func getCredentials() async throws -> Credentials {
        return try await credentialsManager.credentials()
    }
    
    func userIsLoggedIn() -> Bool {
        credentialsManager.hasValid()
    }
    
    func clearLocalDatabase(){
        let entities = sharedCoreDataStack.persistentContainer.managedObjectModel.entities.filter{ entity in
            entity.name != nil
        }.map{ entity in
            entity.name!
        }
        
        for entityName in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
                entityName: entityName
            )
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
            } catch {
                print(
                    "Error deleting all data for entity \(entityName): \(error)"
                )
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving context after deleting data: \(error)")
        }
    }
}
