//
//  CarouselEffectCell.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/09/06.
//

import UIKit

class CarouselEffectCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(index: Int) {
        numberLabel.text = String(index)
        numberLabel.backgroundColor = .random()
    }
}
