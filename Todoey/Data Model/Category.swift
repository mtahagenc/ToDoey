//
//  Category.swift
//  Todoey
//
//  Created by Muhammet Taha Genc on 13.02.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colorName: String = ""
    let items = List<Item>()
}
