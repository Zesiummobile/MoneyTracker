//
//  CategoryAmountViewModelWithAmount.swift
//  MoneyTracker
//
//  Created by Zesium on 11/8/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class CategoryAmountViewModelWithAmount: NSObject, CategoryAmountViewModel {
    // MARK: - CategoryAmountViewModel protocol

    var category: Category

    var showAmount: Bool

    var categoryImage: String

    var categoryName: String

    var categoryAmount: Dynamic<String> = Dynamic("No entries.")

    var startTime: Dynamic<Date>
    var endTime: Dynamic<Date>

    // MARK: - Init

    init(category: Category, startTime: Date, endTime: Date) {
        self.category = category

        showAmount = true
        categoryImage = category.image
        categoryName = category.name
        self.startTime = Dynamic(startTime)
        self.endTime = Dynamic(endTime)

        if let amountCurrency = RealmMapper.getAmount(with: category.id, from: startTime, to: endTime).first {
            categoryAmount = Dynamic("\(amountCurrency.amount) \(amountCurrency.currency)")
        }

        super.init()

        registerNotification()
    }

    deinit {
        unregisterNotification()
    }

    // MARK: - Private methods

    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector (updateAmount),
                                               name: NotificationName.categoryAmountUpdated.getNotification(),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (updateAmount),
                                               name: NotificationName.transactionDeleted.getNotification(),
                                               object: nil)

    }

    fileprivate func unregisterNotification() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc fileprivate func updateAmount() {
        if let amountCurrency =
            RealmMapper.getAmount(with: category.id, from: startTime.value, to: endTime.value).first {
            categoryAmount.value = "\(amountCurrency.amount) \(amountCurrency.currency)"
        }
    }
}
