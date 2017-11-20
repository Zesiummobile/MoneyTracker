//
//  PasswordLoginViewModelFromDB.swift
//  MoneyTracker
//
//  Created by Zesium on 11/17/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

class PasswordLoginViewModelFromDB: NSObject, PasswordLoginViewModel {
    // MARK: - Variables
    var addPassword: Bool

    // MARK: - PasswordLoginViewModel protocol
    var title: String

    var isTouchAuthenticationAvailable: Bool

    // MARK: - Init
    init(addPassword: Bool) {
        self.addPassword = addPassword

        isTouchAuthenticationAvailable = !addPassword
        title = addPassword ? "Add Password" : "Enter Password"

        super.init()
    }

    // MARK: - PasswordLoginViewModel protocol methods

    func validate(input: String) -> Bool {

        if addPassword {
            RealmMapper.save(passcode: input)

            return true
        } else {
            let passcode = RealmMapper.getSettings()?.passcode ?? ""

            if input == passcode {
                return true
            } else {
                return false
            }
        }
    }
}
