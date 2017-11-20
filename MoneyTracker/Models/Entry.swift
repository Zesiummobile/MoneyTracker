//
//  Entries.swift
//  MoneyTracker
//
//  Created by Zesium on 11/7/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import RealmSwift

class Entry: Object, NSCopying {

    // MARK: Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var categoryId: Int = 0
    @objc dynamic var value: Double = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var currency: String = ""
    @objc dynamic var note: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Entry()
        copy.id = id
        copy.categoryId = categoryId
        copy.value = value
        copy.date = date
        copy.currency = currency
        copy.note = note
        return copy
    }
}
