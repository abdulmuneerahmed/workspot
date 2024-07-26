//
//  Date + Extension.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

extension Date {
    /// Formats the date into a string with the format "yyyy-MM-dd".
    var ymdFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
