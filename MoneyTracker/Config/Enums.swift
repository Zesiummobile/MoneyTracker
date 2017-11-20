//
//  Enums.swift
//  MoneyTracker
//
//  Created by Zesium on 11/13/17.
//  Copyright © 2017 Zesium. All rights reserved.
//
import UIKit

enum UserDefaultKeys: String {
    case hasLaunchedBefore // Bool -> Deterimnes whether or not the app has been launched.
}

enum NotificationName: String {
    case categoryAmountUpdated = "CategoryAmountUpdated"
    case transactionDeleted = "TransactionDeleted"

    func getNotification() -> NSNotification.Name {
        return NSNotification.Name(rawValue)
    }
}
