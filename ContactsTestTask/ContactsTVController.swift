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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: UITableViewDelegate
extension ContactsTVController {
    
    override public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 30
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
