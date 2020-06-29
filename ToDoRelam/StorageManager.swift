//
//  StorageManager.swift
//  ToDoRelam
//
//  Created by Александр Уткин on 26.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import Foundation
import RealmSwift
let realm = try! Realm()

class StorageManager {
    
    static func save(task: Task) {
        
        try! realm.write {
            realm.add(task)
        }
    }
}
