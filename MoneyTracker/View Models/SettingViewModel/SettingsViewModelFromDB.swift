//
//  SettingsViewModelFromDB.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class SettingsViewModelFromDB: NSObject, SettingsViewModel {

    // MARK: - SettingsViewModel protocol

    var cellViewModels: [SettingCellViewModel]

    // MARK: - Init

    override init() {
        cellViewModels = []

        if let settings = RealmMapper.getSettings() {
            let currencyType = SettingCellViewModelFromDB.SettingCellType.currency
            let timePeriodType = SettingCellViewModelFromDB.SettingCellType.timePeriod
            let passcodeEnabledType = SettingCellViewModelFromDB.SettingCellType.passcodeEnabled

            cellViewModels.append(SettingCellViewModelFromDB(type: currencyType, state: settings.currency.rawValue))
            cellViewModels.append(SettingCellViewModelFromDB(type: timePeriodType, state: settings.timePeriod.rawValue))
            cellViewModels.append(SettingCellViewModelFromDB(type: passcodeEnabledType,
                                                             state: settings.passcodeEnabled))
        }

        super.init()
    }

}
