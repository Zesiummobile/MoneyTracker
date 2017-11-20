//
//  SettingsTableViewCell.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

protocol SettingsTableViewCellDelegate: class {
    func showLoginPassword()
}

class SettingsTableViewCell: UITableViewCell {

    // MARK: - UI Outlets
    @IBOutlet weak var settingNameLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    @IBOutlet weak var optionLabel: UILabel!

    // MARK: - Variables
    var viewModel: SettingCellViewModel? {
        didSet {
            fillUI()
        }
    }
    weak var delegate: SettingsTableViewCellDelegate?

    // MARK: - Private methods

    fileprivate func fillUI() {
        guard let viewModel = viewModel else { return }

        settingNameLabel.text = viewModel.name

        switch viewModel.type {
        case .currency:
            settingSwitch.isHidden = true
            optionLabel.isHidden = false
            optionLabel.text = Settings.Currency(rawValue: viewModel.state)?.getTitle()
            accessoryType = .disclosureIndicator
        case .timePeriod:
            settingSwitch.isHidden = true
            optionLabel.isHidden = false
            optionLabel.text = Settings.TimePeriod(rawValue: viewModel.state)?.getTitle()
            accessoryType = .disclosureIndicator
        case .passcodeEnabled:
            settingSwitch.isHidden = false
            optionLabel.isHidden = true
            accessoryType = .none
            if viewModel.state == 0 {
                settingSwitch.isOn = false
            } else {
                settingSwitch.isOn = true
            }
        }
    }

    // MARK: - UI Actions
    @IBAction func settingSwitchChanged(_ sender: UISwitch) {
        viewModel?.stateChanged(newState: sender.isOn ? 1 : 0)

        if viewModel?.shouldShowPasswordView() ?? false {
            delegate?.showLoginPassword()
        }
    }

}
