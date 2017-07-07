//
//  ContactsTVController.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import RxSwift

class ContactsTVController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    let vm = ContactsScreenVM()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.relaunch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initBindings()
    }
    
    func initBindings() {
        
        _ = vm.alphabetGroups.asObservable()
            .subscribeOn(MainScheduler.instance)
            .subscribe( onNext: { [weak self] (contact) in
                guard let weakSelf = self else { return }
                weakSelf.tableView.reloadData()
            })
            .disposed(by: disposeBag)        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ContactTVController
        let contactID = { () -> String in
            if let indexPath = tableView.indexPathForSelectedRow {
                return self.vm.contactID(groupIndex: indexPath.section, index: indexPath.row)
            }else{
                return ""
            }
        }()
        let vm = ContactScreenVM(contactID: contactID)
        destVC.vm = vm
    }
    
}

// MARK: UITableViewDelegate
extension ContactsTVController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 28
    }
}

// MARK: UITableViewDataSource
extension ContactsTVController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return vm.groupsCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.contactsCount(groupIndex: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactTVCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = vm.contactFullName(groupIndex: indexPath.section, index: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = vm.groupTitle(groupIndex: section)
        return title
    }
    
}
