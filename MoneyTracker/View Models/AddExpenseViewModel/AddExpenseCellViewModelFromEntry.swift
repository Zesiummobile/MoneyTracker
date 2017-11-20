//
//  AddExpenseCellViewModelFromEntry.swift
//  MoneyTracker
//
//  Created by Zesium on 11/10/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class AddExpenseCellViewModelFromEntry: NSObject, AddExpenseCellViewModel {
    enum AddExpenseCellType: String {
        case amount = "Amount"
        case date = "Date"
        case note = "Note"
    }

    // MARK: - AddExpenseCellViewModel protocol

    var entry: Entry
    var title: String
    var value: Dynamic<String>
    var type: AddExpenseCellType

     // MARK: - Init

    init(entry: Entry, type: AddExpenseCellType) {
        self.entry = entry
        self.type = type
        title = type.rawValue

        switch type {
        case .amount:
            value = Dynamic(entry.value > 0 ? String(entry.value) : "")
        case .date:
            value = Dynamic(AddExpenseCellViewModelFromEntry.getFormattedDate(date: entry.date))
        case .note:
            value = Dynamic(entry.note)
        }

        super.init()
    }

    // MARK: - Private methods

    fileprivate static func getFormattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd. MMM yyyy"

        return formatter.string(from: date)
    }
}
