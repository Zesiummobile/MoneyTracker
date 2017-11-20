//
//  PasswordLoginViewModel.swift
//  MoneyTracker
//
//  Created by Zesium on 11/17/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import Foundation

protocol PasswordLoginViewModel {
    var title: String { get }
    var isTouchAuthenticationAvailable: Bool { get }

    func validate(input: String) -> Bool
}
