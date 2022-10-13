//
//  LayoutCell.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/10/13.
//

import UIKit

enum CompositionalLayoutType: String {
    case simpleLayout = "Simple Layout"
    case verticalTriSectionLayout = "Vertical Tri-Section Layout"
    case none
}

class LayoutCell: UICollectionViewCell {
    var layoutType: CompositionalLayoutType = .none

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(layoutType: CompositionalLayoutType) {
        self.layoutType = layoutType

        setLayout()
    }

    private func setLayout() {
        titleLabel.text = layoutType.rawValue

        collectionView.delegate = self
        collectionView.dataSource = self

        switch layoutType {
        case .simpleLayout:
            collectionView.register(TestNumberCellCollectionViewCell.self)
            collectionView.collectionViewLayout = createSimpleLayout()

        case .verticalTriSectionLayout:
            collectionView.register(TestNumberCellCollectionViewCell.self)
//            collectionView.collectionViewLayout = createVerticalTriSectionLayout()

        default: break
        }
    }

    private func createSimpleLayout() -> UICollectionViewLayout {
        let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0))
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitem: trailingItem, count: 2)

        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [leadingItem, trailingGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        return UICollectionViewCompositionalLayout(section: section)
    }

//    private func createVerticalTriSectionLayout() -> UICollectionViewLayout {
//        let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
//
//        let middleItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
//
//        return UICollectionViewCompositionalLayout(section: <#T##NSCollectionLayoutSection#>)
//    }
}

extension LayoutCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch layoutType {
        case .simpleLayout: return 4
        case .verticalTriSectionLayout: return 0
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TestNumberCellCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(text: String(indexPath.row+1))

        return cell
    }
}
