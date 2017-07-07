//
//  LaunchStorageInteractorFileSystem.swift
//  ContactsTestTask
//
//  Created by Dmitrii Titov on 07.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class LaunchStorageInteractorFileSystem: NSObject {

    fileprivate let encoding = String.Encoding.utf8
    
}

// MARK: LaunchStorageInteractorProtocol
extension LaunchStorageInteractorFileSystem: LaunchStorageInteractorProtocol {
    
    func storageExist() -> Bool {
        return self.filePath() != nil
    }
    
    func getLaunchContacts() -> [TTContact] {
        guard let content = self.fileContent() else {
            return [TTContact]()
        }
        guard let storage = LaunchContactsStorage(JSONString: content) else {
            return [TTContact]()
        }
        //_ = self.clearFile()
        return storage.contacts
    }
    
}

// MARK: Helpers
extension LaunchStorageInteractorFileSystem {
    
    fileprivate func fileContent() -> String? {
        guard let filePath = self.filePath() else { return nil }
        guard let fileHandle = self.fileHandleForRead(filePath: filePath) else { return nil }
        guard let contentSting = String(data: fileHandle.readDataToEndOfFile(), encoding: encoding) else {
            fileHandle.closeFile()
            return nil
        }
        return contentSting
    }
    
    fileprivate func fileHandleForRead(filePath: String) -> FileHandle? {
        guard FileManager.default.fileExists(atPath: filePath) else {
            return nil
        }
        guard let fileHandle = FileHandle(forReadingAtPath: filePath) else {
            return nil
        }
        return fileHandle
    }
    
    fileprivate func fileHandleForUpdation(filePath: String) -> FileHandle? {
        guard FileManager.default.fileExists(atPath: filePath) else {
            return nil
        }
        guard let fileHandle = FileHandle(forUpdatingAtPath: filePath) else {
            return nil
        }
        return fileHandle
    }
    
    fileprivate func filePath() -> String? {
        guard let path = Bundle.main.path(forResource: "ContactsTempleStorage", ofType: "json") else {
            return nil
        }
        
        return path
    }
    
}
