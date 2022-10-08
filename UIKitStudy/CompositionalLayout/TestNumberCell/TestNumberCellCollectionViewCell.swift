//
//  TestNumberCellCollectionViewCell.swift
//  UIKitStudy
//
//  Created by Lotte on 2022/10/03.
//

import UIKit

class TestNumberCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var testNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(text: String) {
        testNumberLabel.text = text
        testNumberLabel.textColor = .white
        self.backgroundColor = .random()
    }
}
