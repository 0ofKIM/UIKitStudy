//
//  SwipeBannerInteractionCell.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/11/27.
//

import UIKit

class SwipeBannerInteractionCell: UICollectionViewCell {
    var panGesture: UIPanGestureRecognizer!
    var playImageCenter: CGPoint?
    var reloadCollectionView: (() -> Void)!
    var isReachReloadPoint = false

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var frontImageViewRightSpacing: NSLayoutConstraint!
    @IBOutlet weak var playImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        frontImageView.layer.cornerRadius = 8
        playImageCenter = playImageView.center

        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(paned(_:)))
        panGesture = pan
        playImageView.addGestureRecognizer(panGesture)
    }

    @objc func tapped(_ gesture: UITapGestureRecognizer) {
        print("클릭")
    }

    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        print("스와이프")
    }

    @objc func paned(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: playImageView)
//        print("팬")
//        print(translation)

        frontImageViewRightSpacing.constant = frontImageViewRightSpacing.constant + (-translation.x)
        playImageView.center.x = playImageView.center.x + translation.x
        gesture.setTranslation(.zero, in: self.playImageView) // 0으로 움직인 값을 초기화 시켜준다.

        if gesture.state == .ended {
            frontImageViewRightSpacing.constant = 30
            playImageView.center = playImageCenter ?? .zero
        }

        if !isReachReloadPoint && frontImageViewRightSpacing.constant >= 100 {
            isReachReloadPoint = true
            playImageView.removeGestureRecognizer(panGesture)

            frontImageViewRightSpacing.constant = UIScreen.main.bounds.width
            UIView.animate(withDuration: 1, animations: { [weak self] in
                self?.layoutIfNeeded()
                self?.playImageView.center.x = 0
                self?.frontImageView.alpha = 0
                self?.playImageView.alpha = 0
            }) { [weak self] _ in
                print("줄인담에 타나?")
                self?.reloadCollectionView()
                self?.frontViewHidden()
            }
        }
    }

    private func frontViewHidden() {
        UIView.animate(withDuration: 2) { [weak self] in
            self?.frontImageView.isHidden = true
            self?.playImageView.isHidden = true
        }
    }
}
