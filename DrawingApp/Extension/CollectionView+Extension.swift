//
//  CollectionView+Extension.swift
//  Yummie
//
//  Created by Abdulrahman on 01/06/2022.
//

import UIKit

extension UICollectionView: Reusable {

    func registerNib<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = Cell.identifier
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
}

extension UICollectionViewCell: Reusable {}
