//
//  TransactionTableViewCell.swift
//  MoneyTracker
//
//  Created by Zesium on 11/15/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    // MARK: - UI Outlets
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    // MARK: - Variables

    var viewModel: TransactionCellViewModel? {
        didSet {
            fillUI()
        }
    }

    // MARK: - Private methods
    fileprivate func fillUI() {
        guard let viewModel = viewModel else { return }

        categoryImageView.image = UIImage(named: viewModel.categoryImage)
        categoryNameLabel.text = viewModel.categoryName
        dateLabel.text = viewModel.date
        amountLabel.text = viewModel.amount
    }

}
