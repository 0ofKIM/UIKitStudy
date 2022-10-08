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
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainMenuCell = collectionView.dequeueReusableCell(for: indexPath)
        if indexPath.row == 0 {
            cell.configure("CollectionView Carousel Effect")
        } else if indexPath.row == 1 {
            cell.configure("Compositional Layout")
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
        } else {
            guard let compositionalLayoutVC = self.storyboard?.instantiateViewController(identifier: "CompositionalLayoutViewController") else { return }
            present(compositionalLayoutVC, animated: true)
        }
    }
}
