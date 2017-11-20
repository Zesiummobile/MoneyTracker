//
//  TransactionViewController.swift
//  MoneyTracker
//
//  Created by Zesium on 11/15/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    // MARK: - UI outlets
    @IBOutlet weak var transactionTableView: UITableView!

    // MARK: - Variables
    var viewModel: TransactionViewModel? {
        didSet {

            transactionTableView.reloadData()
        }
    }

    let flowController = ApplicationFlowController()

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TransactionViewModelFromDate(date: Date())
        viewModel?.cellViewModels.bind({ [unowned self] _ in self.transactionTableView.reloadData() })

        setupUI()
    }

    // MARK: - Private methods

    fileprivate func setupUI() {
        transactionTableView.tableFooterView = UIView()
    }
}

extension TransactionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TransactionTableViewCell"

        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? TransactionTableViewCell {
            cell.selectionStyle = .none

            let cellViewModel = viewModel?.cellViewModels.value[indexPath.row]
            cell.viewModel = cellViewModel

            return cell
        }

        // If unable to dequeue cell, return cell with red background color
        return {
            let wrongCell = UITableViewCell()
            wrongCell.contentView.backgroundColor = .red
            return wrongCell
        }()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cellViewModel = viewModel?.cellViewModels.value[indexPath.row]

            if let succces =
                viewModel?.deleteTransaction(with: cellViewModel?.transactionId ?? -1, indexPath.row), succces {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension TransactionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel?.cellViewModels.value[indexPath.row]

        if let entry = cellViewModel?.entry {
            flowController.showAddExpenseView(navigationController: navigationController, entry: entry)
        }

    }
}
