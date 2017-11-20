//
//  AddExpenseViewModelFromCategory.swift
//  MoneyTracker
//
//  Created by Zesium on 11/10/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class AddExpenseViewModelFromCategory: NSObject, AddExpenseViewModel {
    // MARK: - Variables
    var entry: Entry

    // MARK: - AddExpenseViewModel protocol

    var categoryName: String = ""
    var cellViewModels: [AddExpenseCellViewModel]

    // MARK: - Init

    init(entry: Entry) {
        self.entry = entry
        if let category = RealmMapper.getCategory(with: entry.categoryId) {
            categoryName = category.name
        }

        cellViewModels = [ AddExpenseCellViewModelFromEntry(entry: entry, type: .amount),
                           AddExpenseCellViewModelFromEntry(entry: entry, type: .date),
                           AddExpenseCellViewModelFromEntry(entry: entry, type: .note)]

        super.init()
    }

    // MARK: - AddExpenseViewModel protocol methods
    func saveEntry() {
        RealmMapper.save(entry: entry)

        NotificationCenter.default.post(name: NotificationName.categoryAmountUpdated.getNotification(), object: nil)
    }

}
