//
//  InsertTableViewCell.swift
//  MoneyTracker
//
//  Created by Zesium on 11/10/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class InsertTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!

    // MARK: - Variables
    var viewModel: AddExpenseCellViewModel? {
        didSet {
            fillUI()
        }
    }

    // MARK: - Private methods
    fileprivate func fillUI() {
        guard let viewModel = viewModel else {
            return
        }

        titleLabel.text = viewModel.title
        viewModel.value.bindAndFire({ [unowned self] text in self.valueTextField.text = text })

        switch viewModel.type {
        case .amount:
            valueTextField.isUserInteractionEnabled = true
            valueTextField.keyboardType = .decimalPad
        case .date:
            valueTextField.isUserInteractionEnabled = false
        case.note:
            valueTextField.isUserInteractionEnabled = true
            valueTextField.keyboardType = .default
        }
    }

    // MARK: - UI actions
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if let viewModel = viewModel {

            switch viewModel.type {
            case .amount:
                if let amount = Double(valueTextField.text ?? "") {
                    viewModel.entry.value = amount
                }
            case .date:
                break
            case.note:
                viewModel.entry.note = valueTextField.text ?? ""

            }
        }
    }
}
