//
//  MainTabBarController.swift
//  MoneyTracker
//
//  Created by Zesium on 11/10/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        RealmMapper.addDefaultCategories()
        RealmMapper.addDefaultSetting()
        setDataForExpenseController()
    }

    // MARK: - Private methods

    fileprivate func setDataForExpenseController() {
        let expenseViewModel = ExpenseViewModelFromTimeInterval(date: Date())

        if let navBarVC = viewControllers?.first as? UINavigationController {
            if let expenseVC = navBarVC.viewControllers.first as? ExpenseViewController {
                expenseVC.viewModel = expenseViewModel
            }
        }
    }

}
