//
//  Category.swift
//  MoneyTracker
//
//  Created by Zesium on 11/7/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import RealmSwift

class Category: Object, NSCopying {

    enum CategoryState: Int {
        case deleted
        case hidden
        case normal
    }

    // MARK: Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var stateInt: Int = CategoryState.hidden.rawValue
    var state: CategoryState {
        get {
            return CategoryState(rawValue: stateInt)!
        }
        set {
            stateInt = newValue.rawValue
        }
    }

    override class func primaryKey() -> String? {
        return "id"
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Category()
        copy.id = id
        copy.name = name
        copy.image = image
        copy.stateInt = stateInt
        return copy
    }
}
