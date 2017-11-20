//
//  SettingCellViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol SettingCellViewModel {

    var type: SettingCellViewModelFromDB.SettingCellType { get }
    var name: String { get }
    var state: Int { get }

    func stateChanged(newState: Int)
    func shouldShowPasswordView() -> Bool
}
