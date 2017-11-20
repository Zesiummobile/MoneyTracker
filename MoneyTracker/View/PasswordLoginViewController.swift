//
//  PasswordLoginViewController.swift
//  MoneyTracker
//
//  Created by Zesium on 11/17/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit
import SmileLock

class PasswordLoginViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Variables
    fileprivate let kPasswordDigit = 4
    fileprivate var passwordContainerView: PasswordContainerView!

    var viewModel: PasswordLoginViewModel? {
        didSet {
            fillUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //create PasswordContainerView
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self

        fillUI()
    }

    // MARK: - Private methods

    fileprivate func fillUI() {
        if !self.isViewLoaded {
            return
        }

        guard let viewModel = viewModel else {
            return
        }

        passwordContainerView.touchAuthenticationEnabled = viewModel.isTouchAuthenticationAvailable
        titleLabel.text = viewModel.title

    }

}

extension PasswordLoginViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }

    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension PasswordLoginViewController {
    func validation(_ input: String) -> Bool {
        return viewModel?.validate(input: input) ?? false
    }

    func validationSuccess() {
        dismiss(animated: true, completion: nil)
    }

    func validationFail() {
        passwordContainerView.wrongPassword()
    }
}
