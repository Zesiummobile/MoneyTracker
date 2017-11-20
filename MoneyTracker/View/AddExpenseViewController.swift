//
//  AddExpenseViewController.swift
//  MoneyTracker
//
//  Created by Zesium on 11/10/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var insertTableView: UITableView!

    // MARK: - Variables
    var viewModel: AddExpenseViewModel? {
        didSet {
            fillUI()
        }
    }

    let flowController = ApplicationFlowController()

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fillUI()
    }

    // MARK: - Private methods

    fileprivate func setupUI() {
        insertTableView.tableFooterView = UIView()

        setupNavigationBar()
    }

    func setupNavigationBar() {
        let cancelButton = NavigationButton()
        cancelButton.setButton(title: "Cancel")
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)

        //setup left views
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)

        let saveButton = NavigationButton()
        saveButton.setButton(title: "Save")
        saveButton.addTarget(self, action: #selector(saveButtonAction(_:)), for: .touchUpInside)

        //setup right views
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }

    fileprivate func fillUI() {

        if !self.isViewLoaded {
            return
        }

        guard let viewModel = viewModel else {
            return
        }

        title = viewModel.categoryName
        insertTableView.reloadData()
    }

    // MARK: - UI actions

    @objc func cancelButtonAction(_ sender: Any) {
        insertTableView.resignFirstResponder()

        flowController.dismissAddExpenseView(navigationController: navigationController)
    }

    @objc func saveButtonAction(_ sender: Any) {
        insertTableView.resignFirstResponder()

        if let unwrappedViewModel = viewModel {
            unwrappedViewModel.saveEntry()
        }

        flowController.dismissAddExpenseView(navigationController: navigationController)
    }
}

extension AddExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let insertTableViewIdentifier = "InsertTableViewCell"

        if let cell = tableView.dequeueReusableCell(withIdentifier: insertTableViewIdentifier, for: indexPath)
            as? InsertTableViewCell {
            cell.selectionStyle = .none

            cell.viewModel = viewModel?.cellViewModels[indexPath.row]

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

extension AddExpenseViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellViewModel = viewModel?.cellViewModels[indexPath.row] else { return }

        if cellViewModel.type != .date {
            if let cell = tableView.cellForRow(at: indexPath) as? InsertTableViewCell {
                cell.valueTextField.becomeFirstResponder()
            }
        } else {

        }
    }
}
