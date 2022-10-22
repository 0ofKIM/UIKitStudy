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
    case treeLayout = "Tree Layout"
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

        var layout: UICollectionViewLayout?
        switch layoutType {
        case .simpleLayout: layout = createSimpleLayout()
        case .verticalTriSectionLayout: layout = createVerticalTriSectionLayout()
        case .treeLayout: layout = createTreeLayout()
        default: break
        }

        collectionView.register(TestNumberCellCollectionViewCell.self)
        collectionView.collectionViewLayout = layout ?? UICollectionViewLayout()
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

    private func createVerticalTriSectionLayout() -> UICollectionViewLayout {
        //leading
        let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0))
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 0.0, bottom: 5.0, trailing: 0.0)

        let leadingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0))
        let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitem: leadingItem, count: 3)

        //middle
        let middleItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0))
        let middleItem = NSCollectionLayoutItem(layoutSize: middleItemSize)
        middleItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        //trailing
        let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0))
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 0.0, bottom: 5.0, trailing: 0.0)

        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0))
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitem: leadingItem, count: 3)

        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [leadingGroup, middleItem, trailingGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        return UICollectionViewCompositionalLayout(section: section)
    }

    private func createTreeLayout() -> UICollectionViewLayout {
        //Item
        let leadingBigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let leadingBigItem = NSCollectionLayoutItem(layoutSize: leadingBigItemSize)
        leadingBigItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        let leadingSmallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let leadingSmallItem = NSCollectionLayoutItem(layoutSize: leadingSmallItemSize)
        leadingSmallItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        //group
        let bigGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let bigGroup = NSCollectionLayoutItem(layoutSize: bigGroupSize)
        bigGroup.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        let smallGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
        let smallGroup = NSCollectionLayoutGroup.horizontal(layoutSize: smallGroupSize, subitem: leadingSmallItem, count: 2)
        smallGroup.contentInsets = .zero

        //leading group
        let leadingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitems: [bigGroup, smallGroup, smallGroup])

        //trailing group
        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitems: [smallGroup, smallGroup, bigGroup])

        //nested
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [leadingGroup, trailingGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension LayoutCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch layoutType {
        case .simpleLayout: return 3
        case .verticalTriSectionLayout: return 7
        case .treeLayout: return 10
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TestNumberCellCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(text: String(indexPath.row+1))

        return cell
    }
}
