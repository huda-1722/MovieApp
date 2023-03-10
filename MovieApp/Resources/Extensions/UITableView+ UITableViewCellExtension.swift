//
//  UITableView+ UITableViewCellExtension.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import Foundation
import UIKit


extension UIView {
    static var getIdentifier: String {
        return "\(self)"
    }
}
// MARK: - Table View Extension
extension UITableView {

    ///Returns cell for the given item
    func cell(forItem item: Any) -> UITableViewCell? {
        if let indexPath = self.indexPath(forItem: item) {
            return self.cellForRow(at: indexPath)
        }
        return nil
    }

    ///Returns the indexpath for the given item
    func indexPath(forItem item: Any) -> IndexPath? {
        let itemPosition: CGPoint = (item as AnyObject).convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: itemPosition)
    }

    ///Registers the given cell
    func registerClass(cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.defaultReuseIdentifier)
    }

    ///dequeues a reusable cell for the given indexpath
    func dequeueReusableCellForIndexPath<T: UITableViewCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(T.defaultReuseIdentifier). Ensure you have registered the cell." )
        }

        return cell
    }

    func indexPathForCells(inSection: Int, exceptRows: [Int] = []) -> [IndexPath] {
        let rows = self.numberOfRows(inSection: inSection)
        var indices: [IndexPath] = []
        for row in 0..<rows {
            if exceptRows.contains(row) { continue }
            indices.append([inSection, row])
        }

        return indices
    }
    
    func scrollToLastCell(animated: Bool) {
           let lastSectionIndex = self.numberOfSections - 1 // last section
           let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 2 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
       }
    
    func scrollToBottom() {
           let lastSectionIndex = self.numberOfSections - 1 // last section
           let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        if lastSectionIndex < 0 || lastRowIndex < 1 { return }
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .middle, animated: false)
    }

    ///Register Table View Cell Nib
    func registerCell<T: UITableViewCell>(with identifier: T.Type) {
        self.register(UINib(nibName: identifier.getIdentifier, bundle: nil), forCellReuseIdentifier: identifier.getIdentifier)
    }

    ///Register Header Footer View Nib
    func registerHeaderFooter(with identifier: UITableViewHeaderFooterView.Type) {
        self.register(UINib(nibName: "\(identifier.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: "\(identifier.self)")
    }

    ///Dequeue Table View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath? = nil) -> T {
        if let index = indexPath {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: index) as! T
        } else {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
        }
    }

    ///Dequeue Header Footer View
    func dequeueHeaderFooter <T: UITableViewHeaderFooterView> (with identifier: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: "\(identifier.self)") as! T
    }
    
    func showPaginationLoader(_ show:Bool){
        if show && self.tableFooterView == nil{
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 30)
            indicator.startAnimating()
            self.tableFooterView = indicator
        }else{
            self.tableFooterView = nil
        }
    }
}

extension UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return "\(self)"
    }
}

