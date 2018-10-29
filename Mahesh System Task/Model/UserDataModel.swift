//
//  UserDataModel.swift
//  Mahesh System Task
//
//  Created by Apple on 29/10/18.
//  Copyright © 2018 Mahesh. All rights reserved.
//

import Foundation

struct UserDataModel {
    var repoId: Int?
    var full_name: String?
    var login: String?
    var description: String?
    
    init(full_name: String?, login: String?, description: String?, repoId: Int?) {
        self.full_name = full_name
        self.login = login
        self.description = description
        self.repoId = repoId
    }
}

class UserDataInstance: NSObject {
    
    static let instance = UserDataInstance()
    
    var editedObjects = [UserDataModel]()
    
    func setEditedObject(object: UserDataModel?) {
        guard let object = object else {
            return
        }
        for item in 0..<editedObjects.count {
            if editedObjects[item].repoId == object.repoId {
                editedObjects.remove(at: item)
                break
            }
        }
        editedObjects.append(object)
    }
    
    func removeObject(object: UserDataModel?) {
        guard let object = object else {
            return
        }
        for item in 0..<editedObjects.count {
            if editedObjects[item].repoId == object.repoId {
                editedObjects.remove(at: item)
                break
            }
        }
    }
    
}
