//
//  UIColorExtension.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/09/06.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
