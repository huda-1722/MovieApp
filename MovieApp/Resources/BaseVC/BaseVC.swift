//
//  BaseVC.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import Foundation
import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.bindsDelegates()
        self.setupColors()
        self.setupTexts()
        self.setupFonts()
    }
    
    func initialSetup() { }
    func bindsDelegates() { }
    func setupColors() { }
    func setupTexts() { }
    func setupFonts() { }
    
}
