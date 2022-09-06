//
//  CarouselEffectViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/09/05.
//

import UIKit

class CarouselEffectViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(CarouselEffectCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CarouselEffectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarouselEffectCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(index: indexPath.row+1)
        return cell
    }


}
