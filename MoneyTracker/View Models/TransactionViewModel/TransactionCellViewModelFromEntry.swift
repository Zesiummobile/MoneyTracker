//
//  TransactionCellViewModelFromEntry.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class TransactionCellViewModelFromEntry: NSObject, TransactionCellViewModel {

    // MARK: - TransactionCellViewModel protocol

    var entry: Entry
    var transactionId: Int
    var categoryImage: String
    var categoryName: String
    var date: String
    var amount: String

    // MARK: Init

    init(entry: Entry) {
        self.entry = entry

        let category = RealmMapper.getCategory(with: entry.categoryId)

        transactionId = entry.id
        categoryImage = category?.image ?? ""
        categoryName = category?.name ?? ""
        date = TransactionCellViewModelFromEntry.getFormatted(date: entry.date)
        amount = "\(entry.value) \(entry.currency)"

    }

    // MARK: Private methods

    fileprivate static func getFormatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd. MMM yyyy"

        return formatter.string(from: date)
    }

}
