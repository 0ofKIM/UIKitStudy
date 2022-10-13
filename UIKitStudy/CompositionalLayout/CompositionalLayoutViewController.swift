//
//  CompositionalLayoutViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/10/01.
//

import UIKit

class CompositionalLayoutViewController: UIViewController {
    var compositionalLayout: UICollectionViewCompositionalLayout?

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }

    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LayoutCell.self)
        collectionView.collectionViewLayout = createBaseLayout()
    }
}

extension CompositionalLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell: LayoutCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(layoutType: .simpleLayout)

            return cell
        default: return UICollectionViewCell()
        }
    }
}

extension CompositionalLayoutViewController {
    func createBaseLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(241))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(241))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
