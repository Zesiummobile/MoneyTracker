//
//  AddExpenseCellViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/10/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol AddExpenseCellViewModel {

    var entry: Entry { get }
    var title: String { get }
    var value: Dynamic<String> { get }
    var type: AddExpenseCellViewModelFromEntry.AddExpenseCellType { get }

}
