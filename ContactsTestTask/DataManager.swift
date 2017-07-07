//
//  DataManager.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

private let sharedInstance = DataManager()

class DataManager: NSObject {    
    
    class var shared : DataManager {
        return sharedInstance
    }

    fileprivate let launchStorageInteractor: LaunchStorageInteractorProtocol = LaunchStorageInteractorFileSystem()
    fileprivate let contactsStorageInteractor: ContactsStorageInteractorProtocol = ContactsStorageInteractorCoreData()
    
    func reactOnAppTermination() {
        
    }
    
}

// MARK: Contacts Storage
extension DataManager {
    
    func getAllContacts() -> [TTContact] {
        if self.isFirstLaunch() {
            let contacts = launchStorageInteractor.getLaunchContacts()
            contactsStorageInteractor.addContacts(contacts: contacts)
            return contacts
        }
        return contactsStorageInteractor.getAllContacts()
    }
    
    func addContact(contact: TTContact) -> Bool {
        return contactsStorageInteractor.addContact(contact: contact)
    }
    
    func updateContact(contact: TTContact) -> Bool {
        return contactsStorageInteractor.updateContact(contact: contact)
    }
    
    func deleteContact(withID id: String) -> Bool {
        return contactsStorageInteractor.deleteContact(withID: id)
    }
    
    func clearAllContacts() {
        contactsStorageInteractor.clearAllContacts()
    }
    
}

// MARK: Helpers
extension DataManager {
    
    func isFirstLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        return !launchedBefore
    }
    
}
