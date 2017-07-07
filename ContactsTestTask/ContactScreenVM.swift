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
    }
    
    func relaunch() {
        
    }
    
    func saveContactChanges(contact: TTContact) {
        _ = DataManager.shared.updateContact(contact: contact)
        self.relaunch()
    }
    
}
