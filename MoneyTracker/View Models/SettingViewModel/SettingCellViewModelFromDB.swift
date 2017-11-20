//
//  SettingCellViewModelFromDB.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class SettingCellViewModelFromDB: NSObject, SettingCellViewModel {

    enum SettingCellType {
        case timePeriod
        case currency
        case passcodeEnabled

        func getSettingName() -> String {
            switch self {
            case .currency:
                return "Currency"
            case .timePeriod:
                return "Period"
            case .passcodeEnabled:
                return "Passcode"
            }
        }
    }

    // MARK: - SettingCellViewModel protocol

    var type: SettingCellViewModelFromDB.SettingCellType
    var name: String
    var state: Int

    // MARK: - Init

    init(type: SettingCellType, state: Int) {
        self.name = type.getSettingName()
        self.type = type
        self.state = state

        super.init()
    }

    // MARK: - SettingCellViewModel protocol methods

    func stateChanged(newState: Int) {
        state = newState
        RealmMapper.saveSetting(type: type, newState: newState)
    }

    func shouldShowPasswordView() -> Bool {
        if type == .passcodeEnabled && state == 1 {
            if let settings = RealmMapper.getSettings() {
                if settings.passcode.isEmpty {
                    return true
                }
            }
        }

        return false
    }

}
