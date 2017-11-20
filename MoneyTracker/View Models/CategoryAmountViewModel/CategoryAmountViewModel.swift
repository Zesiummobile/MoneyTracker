//
//  CategoryAmountViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/8/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol CategoryAmountViewModel {
    var category: Category { get }

    var showAmount: Bool { get }
    var categoryImage: String { get }
    var categoryName: String { get }
    var categoryAmount: Dynamic<String> { get }

    var startTime: Dynamic<Date> { get }
    var endTime: Dynamic<Date> { get }

}
