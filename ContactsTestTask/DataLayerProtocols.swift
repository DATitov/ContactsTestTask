//
//  DataLayerProtocols.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import Foundation

protocol LaunchStorageInteractorProtocol {
    func storageExist() -> Bool
    func getLaunchContacts() -> [TTContact]
}

protocol ContactsStorageInteractorProtocol {
    func getAllContacts() -> [TTContact]
    func addContact(contact: TTContact) -> Bool
    func addContacts(contacts: [TTContact])
    func updateContact(contact: TTContact) -> Bool
    func deleteContact(withID id: String) -> Bool
    func clearAllContacts()
    func reactOnAppTermination()
}
