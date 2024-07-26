//
//  SeatModal.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

struct SeatDetails: Codable {
    var bookingId: Int
    var employId: String
    var name: String
    var date: String
    var seatNumber: Int
    var floorNumber: Int
    var reservationStatus: String
}

struct TotalSeat: Codable {
    var seatId: Int
    var seatNumber: Int
    var floorNumber: Int
    var reservationStatus: String
}

extension SeatDetails: Identifiable {
    var id: UUID { UUID() }
}

extension TotalSeat: Identifiable {
    var id: UUID { UUID() }
}

struct LocalSeat: Identifiable {
    var id: UUID = UUID()
    var seatNumber: Int
    var floorNumber: Int
    var date = Date()
    var isSelected: Bool = false
}


struct ReservationSuccess: Codable {
    let status: String
    let bookingId: Int?
}
