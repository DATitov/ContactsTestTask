//
//  TTContactAndContactEntityParser.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import CoreData

class TTContactAndContactEntityParser: NSObject {
    
    func ttContact(coreDataContact cdContact: ContactEntity) -> TTContact {
        let contact = TTContact()
        
        contact.contactID = cdContact.contactID ?? ""
        contact.firstName = cdContact.firstName ?? ""
        contact.lastName = cdContact.lastName ?? ""
        contact.phoneNumber = cdContact.phoneNumber ?? ""
        contact.streetAddress1 = cdContact.streetAddress1 ?? ""
        contact.streetAddress2 = cdContact.streetAddress2 ?? ""
        contact.city = cdContact.city ?? ""
        contact.state = cdContact.state ?? ""
        contact.zipCode = cdContact.zipCode ?? ""
        
        return contact
    }
    
    func coreDataContact(ttContact: TTContact, managedObject: inout ContactEntity) {
        managedObject.setValue(ttContact.contactID, forKey: "contactID")
        managedObject.setValue(ttContact.firstName, forKey: "firstName")
        managedObject.setValue(ttContact.lastName, forKey: "lastName")
        managedObject.setValue(ttContact.phoneNumber, forKey: "phoneNumber")
        managedObject.setValue(ttContact.streetAddress1, forKey: "streetAddress1")
        managedObject.setValue(ttContact.streetAddress2, forKey: "streetAddress2")
        managedObject.setValue(ttContact.city, forKey: "city")
        managedObject.setValue(ttContact.state, forKey: "state")
        managedObject.setValue(ttContact.zipCode, forKey: "zipCode")
    }
    
    func coreDataContactUpdate(ttContact: TTContact, managedObject: inout ContactEntity) {
        managedObject.setValue(ttContact.firstName, forKey: "firstName")
        managedObject.setValue(ttContact.lastName, forKey: "lastName")
        managedObject.setValue(ttContact.phoneNumber, forKey: "phoneNumber")
        managedObject.setValue(ttContact.streetAddress1, forKey: "streetAddress1")
        managedObject.setValue(ttContact.streetAddress2, forKey: "streetAddress2")
        managedObject.setValue(ttContact.city, forKey: "city")
        managedObject.setValue(ttContact.state, forKey: "state")
        managedObject.setValue(ttContact.zipCode, forKey: "zipCode")
    }
    
}
