//
//  ContactsStorageInteractorCoreData.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import CoreData

class ContactsStorageInteractorCoreData: NSObject {
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ContactsTestTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func reactOnAppTermination() {
        self.saveContext()
    }
}

extension ContactsStorageInteractorCoreData: ContactsStorageInteractorProtocol {
    
    func getAllContacts() -> [TTContact] {
        let contactFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactEntity")
        
        let contacts = { () -> [TTContact] in
            do {
                let contacts = try persistentContainer.viewContext.fetch(contactFetch) as! [ContactEntity]
                return contacts.map({ TTContactAndContactEntityParser().ttContact(coreDataContact: $0) })
            } catch {
                return [TTContact]()
            }
        }()
        
        return contacts
    }
    
    func getContact(forID id: String) -> TTContact? {
        guard let managerContact = self.fetchContact(withID: id) else {
            return nil
        }
        
        return TTContactAndContactEntityParser().ttContact(coreDataContact: managerContact as! ContactEntity)
    }
    
    func addContact(contact: TTContact) -> Bool {
        var contactEntity = NSEntityDescription.insertNewObject(forEntityName: "ContactEntity", into: persistentContainer.viewContext) as! ContactEntity
        TTContactAndContactEntityParser().coreDataContact(ttContact: contact, managedObject: &contactEntity)
        
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print(error)
            return false
        }
        
        //let res = self.getAllContacts()
        
        return true
    }
    
    func addContacts(contacts: [TTContact]) {
        contacts.forEach { [weak self] (contact) in
            guard let weakSelf = self else { return }
            _ = weakSelf.addContact(contact: contact)
        }
    }
    
    func updateContact(contact: TTContact) -> Bool {
        //let smth = self.fetchContact(withID: "424D0F89-7729-41AB-9D8B-082DD7D32717")
        guard var contactMO = self.fetchContact(withID: contact.contactID) else {
            return false
        }
        TTContactAndContactEntityParser().coreDataContactUpdate(ttContact: contact, managedObject: &contactMO)
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print(error)
            return false
        }
        return true
    }
    
    func deleteContact(withID id: String) -> Bool {
        guard let contactMO = self.fetchContact(withID: id) else {
            return false
        }
        persistentContainer.viewContext.delete(contactMO)
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print(error)
            return false
        }
        return true
    }
    
    func clearAllContacts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: persistentContainer.viewContext)
        } catch let error as NSError {
            print(error)
        }
    }
}

// MARK: Helpers
extension ContactsStorageInteractorCoreData {
    
    func fetchContact(withID id:String) -> ContactEntity? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactEntity")
        request.predicate = NSPredicate(format: "contactID = %@", argumentArray: [id])
        guard let managedObjects = { () -> [ContactEntity]? in
            do {
                return try persistentContainer.viewContext.fetch(request) as? [ContactEntity]
            } catch let error {
                print(error)
                return nil
            }
            }() else {
                return nil
        }
        
        return managedObjects.count > 0 ? managedObjects[0] : nil
    }
    
}
