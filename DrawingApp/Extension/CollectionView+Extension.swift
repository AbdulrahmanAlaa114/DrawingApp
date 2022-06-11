//
//  CollectionView+Extension.swift
//  Yummie
//
//  Created by Abdulrahman on 01/06/2022.
//

import UIKit

extension UICollectionView: Reusable {

    func registerNib<Cell: UICollectionViewCell>(cell: Cell.Type) {
        self.register(UINib(nibName: Cell.identifier, bundle: nil), forCellWithReuseIdentifier: Cell.identifier)
    }
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
}

extension UICollectionViewCell: Reusable {}
