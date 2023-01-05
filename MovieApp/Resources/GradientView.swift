//
//  GradientView.swift
//  MovieApp
//
//  Created by Huda  on 29/12/22.
//

import Foundation
import UIKit

class GradientView: UIView {
//    override class var layerClass: AnyClass {
//        return CAGradientLayer.self
//    }
//
//    override var layer: CAGradientLayer {
//        return super.layer as! CAGradientLayer
//    }
//
//    var colors: [UIColor]? {
//        get {
//            let layerColors = layer.colors as? [CGColor]
//            return layerColors?.map { UIColor(cgColor: $0) }
//        } set {
//            layer.colors = newValue?.map { $0.cgColor }
//        }
//    }
//
//    open var locations: [NSNumber]? {
//        get {
//            return layer.locations
//        } set {
//            layer.locations = newValue
//        }
//    }
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue, UIColor.purple]
           gradientLayer.startPoint = CGPoint(x: 0, y: 0)
           gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//           gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)

    }
}
