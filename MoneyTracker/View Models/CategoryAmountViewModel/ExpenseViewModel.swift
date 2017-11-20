//
//  ExpenseViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/8/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol ExpenseViewModel {
    var timePeriod: Settings.TimePeriod { get }
    var periodNumber: Int { get }
    var dateIntervalTitle: Dynamic<String> { get }
    var cellViewModels: [CategoryAmountViewModel] { get }

}
