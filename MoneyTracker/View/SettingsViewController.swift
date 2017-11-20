//
//  SettingsViewController.swift
//  MoneyTracker
//
//  Created by Zesium on 11/16/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet weak var settingsTableView: UITableView!

    // MARK: Variables
    var viewModel: SettingsViewModel? {
        didSet {
            settingsTableView.reloadData()
        }
    }

    let flowController = ApplicationFlowController()

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel = SettingsViewModelFromDB()
    }

    // MARK: - Private methods

    fileprivate func setupUI() {
        settingsTableView.tableFooterView = UIView()
    }

}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsTableViewIdentifier = "SettingsTableViewCell"

        if let cell = tableView.dequeueReusableCell(withIdentifier: settingsTableViewIdentifier, for: indexPath)
            as? SettingsTableViewCell {
            cell.selectionStyle = .none

            cell.viewModel = viewModel?.cellViewModels[indexPath.row]
            cell.delegate = self
            return cell

        }

        // If unable to dequeue cell, return cell with red background color
        return {
            let wrongCell = UITableViewCell()
            wrongCell.contentView.backgroundColor = .red
            return wrongCell
        }()

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension SettingsViewController: SettingsTableViewCellDelegate {
    func showLoginPassword() {
        flowController.showPasswordLogin(viewController: navigationController?.tabBarController, addPassword: true)
    }
}
