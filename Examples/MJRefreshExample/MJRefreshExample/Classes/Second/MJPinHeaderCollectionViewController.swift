//
//  MJPinHeaderCollectionViewController.swift
//  MJRefreshExample
//
//  Created by Frank on 2023/9/18.
//  Copyright © 2023 小码哥. All rights reserved.
//

import UIKit

@objcMembers
class MJPinHeaderCollectionViewController: MJCollectionViewController {
    
    convenience init() {
        let pinHeaderLayout = PinHeaderFlowLayout()
        pinHeaderLayout.itemSize = CGSizeMake(80, 80)
        pinHeaderLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        pinHeaderLayout.minimumInteritemSpacing = 20
        pinHeaderLayout.minimumLineSpacing = 20
        pinHeaderLayout.headerReferenceSize = CGSize(width: 100, height: 30)
        
        self.init(collectionViewLayout: pinHeaderLayout)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

@objcMembers
class PinHeaderFlowLayout: UICollectionViewFlowLayout {
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        true
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
        // TODO: Implementation of PinHeader
        
        return attributes
    }

}
