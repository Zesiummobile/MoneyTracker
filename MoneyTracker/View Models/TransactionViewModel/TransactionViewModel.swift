//
//  TransactionViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol TransactionViewModel {
    var cellViewModels: Dynamic<[TransactionCellViewModel]> { get }

    func deleteTransaction(with id: Int, _ index: Int) -> Bool
}
