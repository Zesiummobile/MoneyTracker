//
//  TransactionCellViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol TransactionCellViewModel {

    var entry: Entry { get }
    var transactionId: Int { get }
    var categoryImage: String { get }
    var categoryName: String { get }
    var date: String { get }
    var amount: String { get }

}
