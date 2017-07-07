//
//  ContactsScreenVM.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import RxSwift

class ContactsScreenVM: NSObject {
    
    let disposeBag = DisposeBag()

    let alphabetGroups = Variable<[TTContactsAlphabetGroup]>([TTContactsAlphabetGroup]())
    
    override init() {
        super.init()
        self.relaunch()
    }
    
    func relaunch() {
        let contacts = DataManager.shared.getAllContacts().map({ TTContactShort(ttContact: $0) })
        alphabetGroups.value = self.generateAlphabetGroups(contacts: contacts)
    }
    
    //MARK:- Generating
    
    private func generateAlphabetGroups(contacts: [TTContactShort]) -> [TTContactsAlphabetGroup] {
        let groups = self.generateAlphabetGroups()
        for cntct in contacts {
            var symbolString = ""
            if cntct.fullName.characters.count > 0 {
                symbolString = cntct.fullName.uppercased()
            }
            if symbolString.characters.count <= 0 {
                continue
            }
            let symbol = symbolString.substring(to: symbolString.index(symbolString.startIndex, offsetBy: 1))
            let group = self.group(forName: symbol, groups: groups)
            group.contacts.append(cntct)
        }
        return self.removeEmptyGroups(groups: groups)
    }
    
    private func generateAlphabetGroups() -> [TTContactsAlphabetGroup] {
        var groups = [TTContactsAlphabetGroup]()
        var chrs = AlphabetSource.shared.alphabet(type: .russian)
        chrs = chrs + AlphabetSource.shared.alphabet(type: .english)
        for ch in chrs {
            let group = TTContactsAlphabetGroup()
            group.title = ch
            groups.append(group)
        }
        return groups
    }
    
    private func group(forName name: String, groups: [TTContactsAlphabetGroup]) -> TTContactsAlphabetGroup {
        var group = TTContactsAlphabetGroup()
        for grp in groups {
            if grp.title.uppercased() == name.uppercased() {
                group = grp
                break
            }
        }
        return group
    }
    
    private func removeEmptyGroups(groups: [TTContactsAlphabetGroup]) -> [TTContactsAlphabetGroup] {
        var newGroups = [TTContactsAlphabetGroup]()
        for grp in groups {
            if grp.contacts.count > 0 {
                newGroups.append(grp)
            }
        }
        return newGroups
    }
}

// MARK:- Data Source
extension ContactsScreenVM {
    
    func contactID(groupIndex: Int, index: Int) -> String {
        guard let contact = self.contact(groupIndex: groupIndex, index: index) else {
            return ""
        }
        return contact.contactID
    }
    
    func contactFullName(groupIndex: Int, index: Int) -> String {
        guard let contact = self.contact(groupIndex: groupIndex, index: index) else {
            return ""
        }
        return contact.fullName
    }
    
    func groupTitle(groupIndex: Int) -> String {
        guard let group = self.group(groupIndex: groupIndex) else {
            return ""
        }
        return group.title
    }
    
    func groupsCount() -> Int {
        return alphabetGroups.value.count
    }
    
    func contactsCount(groupIndex: Int) -> Int {
        guard let group = self.group(groupIndex: groupIndex) else {
            return 0
        }
        return group.contacts.count
    }
    
    fileprivate func contact(groupIndex: Int, index: Int) -> TTContactShort? {
        guard let group = self.group(groupIndex: groupIndex) else {
            return nil
        }
        if group.contacts.count <= index {
            return nil
        }
        return group.contacts[index]
    }
    
    fileprivate func group(groupIndex: Int) -> TTContactsAlphabetGroup? {
        if alphabetGroups.value.count <= groupIndex {
            return nil
        }
        return alphabetGroups.value[groupIndex]
    }
    
}
