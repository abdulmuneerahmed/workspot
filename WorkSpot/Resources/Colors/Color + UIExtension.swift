//
//  Color + UIExtension.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 19/07/24.
//

import UIKit

extension UIColor {
    
    convenience init (hexString: String, withAlpha: CGFloat = 1.0) {
        let hexInt = UIColor.intFrom(hexString: hexString)
        self.init(red: CGFloat((hexInt & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hexInt & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hexInt & 0x0000FF) / 255.0,
                  alpha: withAlpha)
    }
    
    private class func intFrom(hexString: String) -> UInt {
        var hexInt: UInt64 = 0
        let scanner: Scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt64(&hexInt)
        return UInt(hexInt)
    }
}
