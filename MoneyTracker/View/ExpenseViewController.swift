//
//  ExpenseViewController.swift
//  MoneyTracker
//
//  Created by Zesium on 11/3/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {

    // MARK: - Constants
    let kCellSpacing: CGFloat = 8
    let kCellsInRow: CGFloat = 3

    // MARK: - Outlets
    @IBOutlet var intervalButton: UIButton!
    @IBOutlet var categoryCollectionView: UICollectionView!

    // MARK: - Variables
    var viewModel: ExpenseViewModel? {
        didSet {
            fillUI()
        }
    }

    let flowController = ApplicationFlowController()

    var categoryCellSize: CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 5 * kCellSpacing) / kCellsInRow
        let cellAspectRatio: CGFloat = 152 / 121
        let cellHeight = cellWidth * cellAspectRatio
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

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

        viewModel.dateIntervalTitle.bindAndFire({ [unowned self] dateInterval in
            self.intervalButton.setTitle(dateInterval, for: .normal)
        })

    }

    // MARK: - UI actions
    @IBAction func intervalButtonAction(_ sender: Any) {
    }

    @IBAction func previousIntervalButtonAction(_ sender: Any) {
    }

    @IBAction func nextIntervalButtonAction(_ sender: Any) {
    }
}

extension ExpenseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {

            let cellIdentifier = "CategoryCollectionViewCell"

            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                as? CategoryCollectionViewCell {

                let cellViewModel = viewModel?.cellViewModels[indexPath.row]
                cell.viewModel = cellViewModel

                return cell
            }

            // If unable to dequeue cell, return cell with red background color
            return {
                let wrongCell = UICollectionViewCell()
                wrongCell.contentView.backgroundColor = .red
                return wrongCell
                }()
    }

}

extension ExpenseViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let category = viewModel?.cellViewModels[indexPath.row].category {
            flowController.showAddExpenseView(navigationController: navigationController, categoryId: category.id)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return categoryCellSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kCellSpacing
    }
}
