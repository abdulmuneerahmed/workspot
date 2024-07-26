//
//  Parameters.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

var myEmpID: String = "5605401"

enum Parameters: String {
    case employId
    case bookingId
    case reservationStatus
    case name
    case date
    case day
    case seatNumber
    case floorNumber
    case empName
    case roomNumber
    case startTime
    case endTime
    case empID
    case booked
    
    var keyValue: String {
        switch self {
        case .employId:
            "employId"
        case .bookingId:
            "bookingId"
        case .reservationStatus:
            "reservationStatus"
        case .name:
            "name"
        case .date:
            "date"
        case .day:
            "day"
        case .seatNumber:
            "seatNumber"
        case .floorNumber:
            "floorNumber"
        case .empName:
            "empName"
        case .roomNumber:
            "roomNumber"
        case .startTime:
            "startTime"
        case .endTime:
            "endTime"
        case .empID:
            "empId"
        case .booked:
            "Booked"
        }
    }
}
