//
//  NavigationButton.swift
//  MoneyTracker
//
//  Created by Zesium on 11/20/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import UIKit

/// NavigationButton - Custom button used in navigation bar items

class NavigationButton: UIButton {
    let customFont = UIFont.systemFont(ofSize: 18)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupButton()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        setupButton()
    }

    func setupButton() {
        titleLabel?.font = customFont
        setTitleColor(.black, for: .normal)
    }

    func setButton(title: String) {
        let fontAttributes = [NSAttributedStringKey.font: customFont]
        let textSize = (title as NSString).size(withAttributes: fontAttributes)

        frame = CGRect(x: 0, y: 0, width: textSize.width, height: 21)
        setTitle(title, for: .normal)

    }
}
