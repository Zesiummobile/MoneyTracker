//
//  CategoryCollectionViewCell.swift
//  MoneyTracker
//
//  Created by Zesium on 11/8/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var moneyAmountContainerView: UIView!
    @IBOutlet weak var moneyAmountLabel: UILabel!

    // MARK: - Variables
    var viewModel: CategoryAmountViewModel? {
        didSet {
            fillUI()
        }
    }

    // MARK: - Private methods
    fileprivate func fillUI() {
        guard let viewModel = viewModel else {
            return
        }

        categoryNameLabel.text = viewModel.categoryName
        categoryImageView.image = UIImage(named: viewModel.categoryImage)

        if viewModel.showAmount {
            moneyAmountContainerView.isHidden = false
            moneyAmountLabel.isHidden = false

            viewModel.categoryAmount.bindAndFire({ [unowned self] value in self.moneyAmountLabel.text = value })
        } else {
            moneyAmountContainerView.isHidden = true
            moneyAmountLabel.isHidden = true
        }
    }
}
