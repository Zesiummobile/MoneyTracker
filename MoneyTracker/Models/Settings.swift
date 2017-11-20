//
//  Settings.swift
//  MoneyTracker
//
//  Created by Zesium on 11/8/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

import RealmSwift

class Settings: Object, NSCopying {

    enum Currency: Int {
        case eur
        case usd
        case rsd

        func getTitle() -> String {
            switch self {
            case .eur:
                return "EUR"
            case .usd:
                return "USD"
            case .rsd:
                return "RSD"
            }
        }
    }

    enum TimePeriod: Int {
        case weekly
        case moonthly
        case yearly

        func getTitle() -> String {
            switch self {
            case .weekly:
                return "Weekly"
            case .moonthly:
                return "Moonthly"
            case .yearly:
                return "Yearly"
            }
        }

        func getEndDate(startDate: Date) -> Date {

            var endTime: Date
            switch self {
            case .weekly:
                endTime = Calendar.current.date(byAdding: .day, value: 7, to: startDate) ?? Date()
            case .moonthly:
                endTime = Calendar.current.date(byAdding: .month, value: 1, to: startDate) ?? Date()
            case .yearly:
                endTime = Calendar.current.date(byAdding: .year, value: 1, to: startDate) ?? Date()
            }

            return endTime
        }
    }

    // MARK: Properties
    @objc dynamic var timePeriodInt: Int = TimePeriod.moonthly.rawValue
    var timePeriod: TimePeriod {
        get {
            return TimePeriod(rawValue: timePeriodInt)!
        }
        set {
            timePeriodInt = newValue.rawValue
        }
    }
    @objc dynamic var currencyInt: Int = Currency.eur.rawValue
    var currency: Currency {
        get {
            return Currency(rawValue: currencyInt)!
        }
        set {
            currencyInt = newValue.rawValue
        }
    }
    @objc dynamic var passcodeEnabled: Int = 0
    @objc dynamic var passcode: String = ""

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Settings()
        copy.timePeriodInt = timePeriodInt
        copy.currencyInt = currencyInt
        copy.passcodeEnabled = passcodeEnabled
        copy.passcode = passcode
        return copy
    }
}
