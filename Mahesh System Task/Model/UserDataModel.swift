//
//  UserDataModel.swift
//  Mahesh System Task
//
//  Created by Apple on 29/10/18.
//  Copyright © 2018 Mahesh. All rights reserved.
//

import Foundation

// MARk: Storing Into Models
struct RepositoryModel: Codable {
    var items: [UserDataModel]?
}

struct UserDataModel: Codable {
    var repoId: Int?
    var fullName: String?
    var owner: owner?
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case repoId = "id"
        case fullName = "full_name"
        case owner
        case description
    }
    
}

struct owner: Codable {
    var login: String?
}

// MARk: Storing and updating Data
struct UserDataInstance {
    static var editedObjects = [UserDataModel]()
}
