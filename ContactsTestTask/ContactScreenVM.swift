//
//  ContactScreenVM.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import RxSwift

class ContactScreenVM: NSObject {
    
    let disposeBag = DisposeBag()
    
    let contact = Variable<TTContact>(TTContact())
    
    var contactID = ""
    
    init(contactID: String) {
        super.init()
        self.contactID = contactID
        
        self.relaunch()
    }
    
    func relaunch() {
        contact.value = { [weak self] () -> TTContact in
            guard let weakSelf = self else { return TTContact() }
            if let contact = DataManager.shared.getContact(forID: weakSelf.contactID) {
                return contact
            }else{
                let newContact = TTContact()
                weakSelf.contactID = newContact.contactID
                if !DataManager.shared.addContact(contact: newContact) {
                    print("not saved")
                }
                return newContact
            }
        }()
    }
    
    func saveContactChanges(contact: TTContact) {
        if !DataManager.shared.updateContact(contact: contact) {
            print("not saved")
        }
        self.relaunch()
    }
    
    func clearIfNeeded() {
        var fullName = (contact.value.firstName + contact.value.lastName).replacingOccurrences(of: " ", with: "")
        
        if fullName.characters.count <= 0 {
            self.deleteContact()
        }
    }
    
    func deleteContact() {
        _ = DataManager.shared.deleteContact(withID: contact.value.contactID)
    }
    
}
