//
//  MainMenuCell.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/08/31.
//

import UIKit

class MainMenuCell: UICollectionViewCell {
    @IBOutlet weak var titleButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ title: String) {
        titleButton.setTitle(title, for: .normal)
    }
}
