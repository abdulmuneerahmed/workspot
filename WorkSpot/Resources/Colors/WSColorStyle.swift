//
//  WSColorStyle.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 19/07/24.
//

import SwiftUI

protocol WSColorStyle {
    static var brandColor                  : Color { get }
    static var seaGreen                    : Color { get }
    static var corebrandColor              : Color { get }
    static var textfieldborderColor        : Color { get }
    static var placeholderColor            : Color { get }
    static var blacktextColor              : Color { get }
}

extension Color: WSColorStyle {
    static var seaGreen: Color {
        Color(UIColor(hexString: "#D4DFAF"))
    }
    
    static var corebrandColor: Color {
        Color(UIColor(hexString: "#006A4D"))
    }
    
    static var brandColor: Color {
        Color(UIColor(hexString: "#3A8444"))
    }
    
    static var textfieldborderColor: Color {
        Color(UIColor(hexString: "#ABADB0"))
    }
    
    static var placeholderColor: Color {
        Color(UIColor(hexString: "#878B8F"))
    }
    
    static var blacktextColor: Color {
        Color(UIColor(hexString: "#101317"))
    }
}
