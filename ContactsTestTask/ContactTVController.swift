//
//  ContactTVController.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer

class ContactTVController: UITableViewController {

    var vm: ContactScreenVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: UITableViewDelegate
extension ContactTVController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alertView = self.alertView(forIndex: indexPath.row)
        self.presentAlertView(alertView: alertView)
    }
    
}

// MARK: Helpers
extension ContactTVController {
    
    func alertView(forIndex index: Int) -> PropertyEditingAlertView {
        let alertView = { () -> PropertyEditingAlertView in
            let contact = self.vm.contact.value
            switch index {
            case 0:
                return PropertyEditingAlertView(title: "Name", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 1:
                return PropertyEditingAlertView(title: "Last name", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 2:
                return PropertyEditingAlertView(title: "Address line 1", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 3:
                return PropertyEditingAlertView(title: "Address line 2", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 4:
                return PropertyEditingAlertView(title: "Phone number", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 5:
                return PropertyEditingAlertView(title: "City", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 6:
                return PropertyEditingAlertView(title: "State", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 7:
                return PropertyEditingAlertView(title: "Zip code", value: contact.firstName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.firstName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            default:
                return PropertyEditingAlertView(title: "", value: "", saveAction: { _ in  })
            }
        }()
        return alertView
    }
    
    fileprivate func presentAlertView(alertView: PropertyEditingAlertView) {
        let vc = DTAlertViewContainerController()
        alertView.valueTextField.autocapitalizationType = .none
        vc.presentOverVC(self, alert: alertView, appearenceAnimation: .fromTop, completion: nil)
    }
    
}
 
