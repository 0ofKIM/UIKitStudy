//
//  CarouselEffectViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/09/05.
//

import UIKit

class CarouselEffectViewController: UIViewController {
    var currentIndex: Double = 0.0
    var offsetCollectionViewInset: CGFloat = (UIScreen.main.bounds.width - 200) / 2.0
    var previousIndex = 0

    @IBOutlet weak var pagingCollectionView: UICollectionView!
    @IBOutlet weak var offsetCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }

    private func setCollectionView() {
        pagingCollectionView.register(CarouselEffectCell.self)
        pagingCollectionView.delegate = self
        pagingCollectionView.dataSource = self

        offsetCollectionView.register(CarouselEffectCell.self)
        offsetCollectionView.delegate = self
        offsetCollectionView.dataSource = self
        offsetCollectionView.decelerationRate = .normal
    }
}

extension CarouselEffectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarouselEffectCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(index: indexPath.row+1)
        if indexPath.row == 1 {
            animateZoomforCellremove(zoomCell: cell)
        }
        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == offsetCollectionView {
            setPagingOffset(targetContentOffset)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == pagingCollectionView {
            return .zero
        } else {
            return UIEdgeInsets(top: 0, left: offsetCollectionViewInset, bottom: 0, right: offsetCollectionViewInset)
        }
    }

    private func setPagingOffset(_ targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let collectionViewLayout = offsetCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let cellWidth = collectionViewLayout?.itemSize.width ?? 0
        let lineSpacing = collectionViewLayout?.minimumLineSpacing ?? 0
        let offsetX = targetContentOffset.pointee.x

        let contentWidth = cellWidth + lineSpacing
        var currentIndex = Int(round((offsetCollectionViewInset + offsetX)/contentWidth))
        if currentIndex > previousIndex {
            currentIndex = previousIndex + 1
        } else {
            currentIndex = previousIndex - 1
        }

        targetContentOffset.pointee.x = contentWidth * CGFloat(currentIndex)
        previousIndex = Int(currentIndex)

        //애니메이션
        if let cell = offsetCollectionView.cellForItem(at: .init(row: currentIndex, section: 0)) {
            animateZoomforCell(zoomCell: cell)
        }

        if let cell = offsetCollectionView.cellForItem(at: .init(row: currentIndex+1, section: 0)) {
            animateZoomforCellremove(zoomCell: cell)
        }

        if let cell = offsetCollectionView.cellForItem(at: .init(row: currentIndex-1, section: 0)) {
            animateZoomforCellremove(zoomCell: cell)
        }
    }

    func animateZoomforCell(zoomCell: UICollectionViewCell) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                zoomCell.transform = .identity
            },
            completion: nil)
    }

    func animateZoomforCellremove(zoomCell: UICollectionViewCell) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                zoomCell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            },
            completion: nil)

    }
}
