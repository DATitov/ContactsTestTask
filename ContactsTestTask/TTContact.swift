//
//  TTContact.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import ObjectMapper

class TTContact: NSObject, Mappable {
    
    var contactID: String = UUID().uuidString
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var streetAddress1: String = ""
    var streetAddress2: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        contactID <- map["contactID"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        phoneNumber <- map["phoneNumber"]
        streetAddress1 <- map["streetAddress1"]
        streetAddress2 <- map["streetAddress2"]
        city <- map["city"]
        state <- map["state"]
        zipCode <- map["zipCode"]
    }
    
}
