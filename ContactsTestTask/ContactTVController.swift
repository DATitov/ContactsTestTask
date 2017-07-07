//
//  ContactTVController.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import DTAlertViewContainer
import RxSwift

class ContactTVController: UITableViewController {

    let disposeBag = DisposeBag()
    
    var vm: ContactScreenVM!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initBindings()
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        vm.clearIfNeeded()
    }
    
    func initBindings() {
        
        _ = vm.contact.asObservable()
        .subscribeOn(MainScheduler.instance)
        .subscribe( onNext: { [weak self] (contact) in
            DispatchQueue.main.async {
                guard let weakSelf = self else { return }
                weakSelf.title = contact.firstName + " " + contact.lastName
                
                weakSelf.firstNameLabel.text = contact.firstName
                weakSelf.lastNameLabel.text = contact.lastName
                weakSelf.address1Label.text = contact.streetAddress1
                weakSelf.address2Label.text = contact.streetAddress2
                weakSelf.phoneNumberLabel.text = contact.phoneNumber
                weakSelf.cityLabel.text = contact.city
                weakSelf.stateLabel.text = contact.state
                weakSelf.zipCodeLabel.text = contact.zipCode
                
                weakSelf.tableView.reloadData()
            }
        })
        .disposed(by: disposeBag)
        
    }
    
    @IBAction func deleteContactButtonPressed(_ sender: Any) {
        vm.deleteContact()
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "contactTVCellIdentifier", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = vm.contact.value.firstName
            break
        case 1:
            cell.detailTextLabel?.text = vm.contact.value.lastName
            break
        case 2:
            cell.detailTextLabel?.text = vm.contact.value.phoneNumber
            break
        case 3:
            cell.detailTextLabel?.text = vm.contact.value.streetAddress1
            break
        case 4:
            cell.detailTextLabel?.text = vm.contact.value.streetAddress2
            break
        case 5:
            cell.detailTextLabel?.text = vm.contact.value.city
            break
        case 6:
            cell.detailTextLabel?.text = vm.contact.value.state
            break
        case 7:
            cell.detailTextLabel?.text = vm.contact.value.zipCode
            break
        default:
            break
        }
        
        return cell
        }else{
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
}

// MARK: UITableViewDelegate
extension ContactTVController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alertView = self.alertView(forIndex: indexPath.row)
        self.presentAlertView(alertView: alertView)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }else{
            return self.calculateHeightForDeleteCell()
        }
    }
    
}

// MARK: Helpers
extension ContactTVController {
    
    func calculateHeightForDeleteCell() -> CGFloat {
        let defaultHeight: CGFloat = 120.0
        let tvHeight = tableView.frame.size.height - (navigationController?.navigationBar.frame.size.height)!
        let contentHeight = { () -> CGFloat in 
            var contentHeight: CGFloat = 0
            for row in 0..<tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 0) {
                contentHeight += tableView.delegate!.tableView!(tableView, heightForRowAt: IndexPath(row: row, section: 0))
            }
            return contentHeight
        }()
        
        return max(defaultHeight, tvHeight - contentHeight)
    }
    
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
                return PropertyEditingAlertView(title: "Last name", value: contact.lastName, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.lastName = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 2:
                return PropertyEditingAlertView(title: "Phone number", value: contact.phoneNumber, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.phoneNumber = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 3:
                return PropertyEditingAlertView(title: "Address line 1", value: contact.streetAddress1, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.streetAddress1 = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 4:
                return PropertyEditingAlertView(title: "Address line 2", value: contact.streetAddress2, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.streetAddress2 = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 5:
                return PropertyEditingAlertView(title: "City", value: contact.city, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.city = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 6:
                return PropertyEditingAlertView(title: "State", value: contact.state, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.state = value
                    weakSelf.vm.saveContactChanges(contact: contact)
                })
            case 7:
                return PropertyEditingAlertView(title: "Zip code", value: contact.zipCode, saveAction: { [weak self] (value) in
                    guard let weakSelf = self else { return }
                    contact.zipCode = value
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
 
