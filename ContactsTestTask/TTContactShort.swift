//
//  TTContactShort.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class TTContactShort: NSObject {
    
    var contactID: String = ""
    var fullName: String = ""
    
    init(ttContact: TTContact) {
        super.init()
        contactID = ttContact.contactID
        fullName = ttContact.firstName + " " + ttContact.lastName
    }
    
}
