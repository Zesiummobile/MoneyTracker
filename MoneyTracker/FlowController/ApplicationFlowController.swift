//
//  ApplicationFlowController.swift
//  MoneyTracker
//
//  Created by Zesium on 11/9/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

/// ApplicationFlowController - Configuring view controllers for specific context and presenting controllers
class ApplicationFlowController {

    /**
     Providing Add Expense controller with objects it needs to fulfill it’s role
     */
    func showAddExpenseView(navigationController: UINavigationController?,
                            categoryId: Int? = nil, entry: Entry? = nil) {

        var viewModel: AddExpenseViewModelFromCategory?
        if let unwrappedEntry = entry {
            viewModel = AddExpenseViewModelFromCategory(entry: unwrappedEntry)
        } else if let unwrappedCategoryId = categoryId {
            let settings = RealmMapper.getSettings()

            let newEntry = Entry()
            newEntry.id = RealmMapper.getEntryIdIncremeter()
            newEntry.categoryId = unwrappedCategoryId
            newEntry.currency = settings?.currency.getTitle() ?? ""

            viewModel = AddExpenseViewModelFromCategory(entry: newEntry)
        }

        if let unwrappedViewModel = viewModel {
            let vc = StoryboardScene.Main.addExpenseViewController.instantiate()
            vc.viewModel = unwrappedViewModel

            let navBarController = UINavigationController(rootViewController: vc)

            DispatchQueue.main.async {
                navigationController?.present(navBarController, animated: true, completion: nil)
            }
        }

    }

    func dismissAddExpenseView(navigationController: UINavigationController?) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    func showPasswordLogin(viewController: UIViewController?, addPassword: Bool) {
        let viewModel = PasswordLoginViewModelFromDB(addPassword: addPassword)

        let loginVC = StoryboardScene.Main.passwordLoginViewController.instantiate()
        loginVC.modalPresentationStyle = .overCurrentContext
        loginVC.viewModel = viewModel
        viewController?.present(loginVC, animated: true, completion: nil)
    }

    /**
     Check if passcode is enable and show PasswordLogin controller from presented view controller
     */
    func showPasswordLogin(appDelegate: AppDelegate) {
        let settings = RealmMapper.getSettings()

        if let passcodeEnabled = settings?.passcodeEnabled, passcodeEnabled == 1 {
            if let tabBarController = appDelegate.window?.rootViewController as? UITabBarController {
                if let presentedViewController = tabBarController.presentedViewController {
                    showPasswordLogin(viewController: presentedViewController, addPassword: false)
                } else {
                    showPasswordLogin(viewController: tabBarController, addPassword: false)
                }
            }
        }
    }
}
