//
//  ViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(MainMenuCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainMenuCell = collectionView.dequeueReusableCell(for: indexPath)
        if indexPath.row == 0 {
            cell.configure("CollectionView Carousel Effect")
        } else if indexPath.row == 1 {
            cell.configure("Compositional Layout")
        } else if indexPath.row == 2 {
            cell.configure("Async Await")
        } else if indexPath.row == 3 {
            cell.configure("Swipe Banner Interaction")
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width
        return CGSize(width: cellWidth, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let carouselEffectVC = self.storyboard?.instantiateViewController(identifier: "CarouselEffectViewController") else { return }
            present(carouselEffectVC, animated: true)
        } else if indexPath.row == 1 {
            guard let compositionalLayoutVC = self.storyboard?.instantiateViewController(identifier: "CompositionalLayoutViewController") else { return }
            present(compositionalLayoutVC, animated: true)
        } else if indexPath.row == 2 {
            guard let asyncAwaitVC = self.storyboard?.instantiateViewController(identifier: "AsyncAwaitViewController") else { return }
            present(asyncAwaitVC, animated: true)
        } else {
            guard let swipeBannerInteractionVC = self.storyboard?.instantiateViewController(identifier: "SwipeBannerInteractionViewController") else { return }
            present(swipeBannerInteractionVC, animated: true)
        }
    }
}
