//
//  AppFonts.swift
//  MovieApp
//
//  Created by Huda  on 31/12/22.
//

import Foundation
import UIKit
enum AppFonts: String {
    case SourceSansProRegular = "SourceSansPro-Regular"
    case SourceSansProExtraLight = "SourceSansPro-ExtraLight"
    case SourceSansProLight = "SourceSansPro-Light"
    case SourceSansProSemiBold = "SourceSansPro-SemiBold"
    case SourceSansProBold = "SourceSansPro-Bold"
    case PlayfairDisplay_Bold = "PlayfairDisplay-Bold"
    case PlayfairDisplay_SemiBold = "PlayfairDisplay-SemiBold"
    case Roboto_Bold = "Roboto-Bold"
    case IBM_PlexSans_Bold = "IBMPlexSans-Bold"


}
extension AppFonts {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    func withDefaultSize() -> UIFont {
        return UIFont(name: self.rawValue, size: 15.0) ?? UIFont.systemFont(ofSize: 15.0)
    }
    
}

