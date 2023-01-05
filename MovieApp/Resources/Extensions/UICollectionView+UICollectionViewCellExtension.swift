//
//  UICollectionView+UICollectionViewCellExtension.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import Foundation
import UIKit

// MARK: - UICollectionView Extension
extension UICollectionView {

    ///Returns cell for the given item
    func cell(forItem item: AnyObject) -> UICollectionViewCell? {
        if let indexPath = self.indexPath(forItem: item) {
            return self.cellForItem(at: indexPath)
        }
        return nil
    }

    ///Returns the indexpath for the given item
    func indexPath(forItem item: AnyObject) -> IndexPath? {
        let buttonPosition: CGPoint = item.convert(CGPoint.zero, to: self)
        return self.indexPathForItem(at: buttonPosition)
    }

   

}

extension UICollectionViewCell {
    public static var defaultReuseIdentifier: String {
        return "\(self)"
    }
}
///Registers the given cell
extension UICollectionView {
    
    func dequeueCell<T: UICollectionViewCell>(with identifier: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: identifier.getIdentifier, for: indexPath) as! T
    }
    
    func registerCell<T: UICollectionViewCell>(with identifier: T.Type) {
        self.register(UINib(nibName: identifier.getIdentifier, bundle: nil), forCellWithReuseIdentifier: identifier.getIdentifier)
    }
    func dequeSupplementartView<T: UICollectionReusableView>(kind:String, with identifier:T.Type, indexpath:IndexPath) -> T{
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier.getIdentifier, for: indexpath) as! T
    }
    func registerSupplementaryView<T: UICollectionReusableView>(with identifier:T.Type,kind:String){
        self.register(UINib(nibName: identifier.getIdentifier, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier.getIdentifier)
    }
}
