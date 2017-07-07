//
//  LaunchContactsStorage.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import ObjectMapper

class LaunchContactsStorage: NSObject, Mappable {
    
    var contacts = [TTContact]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        contacts <- map["contacts"]
    }

}
