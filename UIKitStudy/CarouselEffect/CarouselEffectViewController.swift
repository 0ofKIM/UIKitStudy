//
//  CarouselEffectViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/09/05.
//

import UIKit

class CarouselEffectViewController: UIViewController {
    var currentIndex: Double = 0.0

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
    }
}

extension CarouselEffectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarouselEffectCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(index: indexPath.row+1)
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
            return UIEdgeInsets(top: 0, left: 200, bottom: 0, right: 200)
        }
    }

    private func setPagingOffset(_ targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let collectionViewLayout = offsetCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let leftInset = offsetCollectionView.adjustedContentInset.left
        let cellWidth = collectionViewLayout?.itemSize.width ?? 0
        let lineSpacing = collectionViewLayout?.minimumLineSpacing ?? 0
        let offsetX = targetContentOffset.pointee.x

        let contentWidth = cellWidth + lineSpacing
        let currentIndex = round((leftInset + offsetX)/contentWidth)

        print(collectionViewLayout?.sectionInset.left) // xib 기준으로 잡히는 상태...

        targetContentOffset.pointee.x = contentWidth * currentIndex - leftInset
    }
}
