//
//  TransactionViewModelFromDate.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class TransactionViewModelFromDate: NSObject, TransactionViewModel {
    // MARK: - Variables
    var date: Date

    // MARK: - TransactionViewModel protocol
    var cellViewModels: Dynamic<[TransactionCellViewModel]>

    // MARK: - Init
    init(date: Date) {
        self.date = date
        cellViewModels = Dynamic(TransactionViewModelFromDate.getTransactions(date: date))

        super.init()
        registerNotification()
    }

    deinit {
        unregisterNotification()
    }

    // MARK: - TransactionViewModel protocol methods
    func deleteTransaction(with id: Int, _ index: Int) -> Bool {
        if RealmMapper.deleteEntry(with: id) {
            NotificationCenter.default.post(name: NotificationName.transactionDeleted.getNotification(), object: nil)

            // disable listener 
            let listener  = cellViewModels.listener
            cellViewModels.listener = nil
            cellViewModels.value.remove(at: index)
            cellViewModels.listener = listener

            return true
        } else {
            return false
        }
    }

    // MARK: - Private methods
    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector (updateTransaction),
                                               name: NotificationName.categoryAmountUpdated.getNotification(),
                                               object: nil)
    }

    fileprivate func unregisterNotification() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc fileprivate func updateTransaction() {
        cellViewModels.value = TransactionViewModelFromDate.getTransactions(date: date)
    }

    fileprivate static func getTransactions(date: Date) -> [TransactionCellViewModel] {
        let timePeriod = RealmMapper.getSettings()?.timePeriod ?? .moonthly
        let periodNumber = ExpenseViewModelFromTimeInterval.getPeriodNumber(for: date, timePeriod)

        let startDate = ExpenseViewModelFromTimeInterval.getFirstDay(timePeriod: timePeriod,
                                                                     periodNumber: periodNumber, date: date) ?? Date()
        let endDate = timePeriod.getEndDate(startDate: startDate)

        let entries = RealmMapper.getEntries(from: startDate, to: endDate)

        var cellViewModels: [TransactionCellViewModel] = []
        for entry in entries {
            cellViewModels.append(TransactionCellViewModelFromEntry(entry: entry))
        }

        return cellViewModels
    }
}
