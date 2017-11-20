//
//  AddExpenseViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/10/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol AddExpenseViewModel {

    var categoryName: String { get }
    var cellViewModels: [AddExpenseCellViewModel] { get }

    func saveEntry()
}
