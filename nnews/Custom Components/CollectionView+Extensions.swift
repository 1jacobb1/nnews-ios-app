//
//  CollectionView+Extensions.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit

extension UICollectionView {
    func snapToCenter(view: UIView) {
        let centerPoint = view.convert(view.center, to: self)
        guard let centerIndexPath = indexPathForItem(at: centerPoint) else { return }
        scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
    }
}
