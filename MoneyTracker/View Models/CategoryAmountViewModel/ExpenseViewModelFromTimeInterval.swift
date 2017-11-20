//
//  ExpenseViewModelFromTimeInterval.swift
//  MoneyTracker
//
//  Created by Zesium on 11/8/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class ExpenseViewModelFromTimeInterval: NSObject, ExpenseViewModel {
    // MARK: - Variables
    var firstDate: Date

    // MARK: - ExpenseViewModel protocol

    var timePeriod: Settings.TimePeriod

    var periodNumber: Int

    var dateIntervalTitle: Dynamic<String>

    var cellViewModels: [CategoryAmountViewModel]

    // MARK: Init
    init(date: Date) {
        timePeriod = RealmMapper.getSettings()?.timePeriod ?? .moonthly
        periodNumber = ExpenseViewModelFromTimeInterval.getPeriodNumber(for: date, timePeriod)

        self.firstDate = ExpenseViewModelFromTimeInterval.getFirstDay(timePeriod: timePeriod,
                                                                      periodNumber: periodNumber, date: date) ?? Date()

        dateIntervalTitle = Dynamic(ExpenseViewModelFromTimeInterval.getDateIntervalTitle(timePeriod: timePeriod,
                                                                                          firstDate: firstDate))

        cellViewModels = ExpenseViewModelFromTimeInterval.getCategoryAmounts(type: .normal,
                                                                             firstDate: firstDate,
                                                                             timePeriod: timePeriod)

        super.init()
    }

    // MARK: Private methods

    fileprivate static func getDateIntervalTitle(timePeriod: Settings.TimePeriod, firstDate: Date)
        -> String {
            let formatter = DateFormatter()

            switch timePeriod {
            case .weekly:
                let endTime = Calendar.current.date(byAdding: .day, value: 7, to: firstDate) ?? Date()
                formatter.dateFormat = "dd. MMM"

                let startTimeStr = formatter.string(from: firstDate)
                let endTimeStr = formatter.string(from: endTime)

                return "\(startTimeStr) - \(endTimeStr)"
            case .moonthly:
                formatter.dateFormat = "MMM"

                let monthName = formatter.string(from: firstDate)

                return monthName
            case .yearly:
                formatter.dateFormat = "yyyy"

                let year = formatter.string(from: firstDate)

                return year
            }
    }

    fileprivate static func getCategoryAmounts(type: Category.CategoryState,
                                               firstDate: Date,
                                               timePeriod: Settings.TimePeriod) -> [CategoryAmountViewModel] {

        var categoryAmounts = [CategoryAmountViewModel]()

        let endTime = timePeriod.getEndDate(startDate: firstDate)
        for category in RealmMapper.getCategories(state: type) {
            let categoryAmountViewModel = CategoryAmountViewModelWithAmount(category: category,
                                                                            startTime: firstDate,
                                                                            endTime: endTime)
            categoryAmounts.append(categoryAmountViewModel)
        }

        return categoryAmounts
    }

    // MARK: Public methods

    /*
     Get period number based on given date - week number of year, month number or year
     */
    static func getPeriodNumber(for date: Date, _ timePeriod: Settings.TimePeriod) -> Int {
        var periodNumber = 0

        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        calendar.firstWeekday = 2 // Monday
        calendar.minimumDaysInFirstWeek = 4

        switch timePeriod {
        case .weekly:
            periodNumber = calendar.component(.weekOfYear, from: date)
        case .moonthly:
            periodNumber = calendar.component(.month, from: date)
        case .yearly:
            periodNumber = calendar.component(.year, from: date)
        }

        return periodNumber
    }

    /*
     Get first date for given time period and period number
     */
    static func getFirstDay(timePeriod: Settings.TimePeriod, periodNumber: Int, date: Date) -> Date? {
        let Calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var dayComponent = DateComponents()

        switch timePeriod {
        case .weekly:
            dayComponent.weekOfYear = periodNumber
            dayComponent.weekday = 1
            dayComponent.year = Calendar.components(.year, from: date).year ?? 0
        case .moonthly:
            dayComponent.month = periodNumber
            dayComponent.year = Calendar.components(.year, from: date).year ?? 0
        case .yearly:
            dayComponent.year = periodNumber
        }

        return Calendar.date(from: dayComponent)

    }
}
