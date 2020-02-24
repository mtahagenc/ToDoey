//
//  Item.swift
//  Todoey
//
//  Created by Muhammet Taha Genc on 13.02.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
