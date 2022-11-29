//
//  SwipeBannerInteractionViewController.swift
//  UIKitStudy
//
//  Created by 0ofKim on 2022/11/26.
//

import UIKit

class SwipeBannerInteractionViewController: UIViewController {
    var bannerHeight: CGFloat = 100
    var expandedBanner = false

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }

    private func setCollectionView() {
        collectionView.register(MainMenuCell.self)
        collectionView.register(SwipeBannerInteractionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SwipeBannerInteractionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 || indexPath.row == 2 {
            let cell: MainMenuCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure("여백")
            return cell
        } else {
            let cell: SwipeBannerInteractionCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.reloadCollectionView = { [weak self] in
                self?.expandedBanner = true
                self?.bannerHeight = 300

                UIView.animate(withDuration: 0.5) {
                    self?.collectionView.performBatchUpdates({
                        self?.collectionView.reloadData()
                        cell.backgroundImageView.backgroundColor = .purple
                    })
                }
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: indexPath.row == 1 ? bannerHeight : 50)
    }
}
