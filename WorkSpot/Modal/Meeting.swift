//
//  Meeting.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

struct MeetingRoomsResponse: Codable {
    var bookedRoomInfoList: [BookedRoomInfoList]
    var roomInfo: [RoomInfo]
}

struct BookedRoomInfoList: Codable {
    var floorNumber: Int
    var roomNumber: Int
    var date: String
    var reservedTimeSlots: [TimeSlot]
}

struct TimeSlot: Codable {
    var startTime: String
    var endTime: String
}

struct RoomBookingsList: Codable {
    var bookingId: Double
    var empId: Int
    var empName: String
    var roomNumber: Int
    var floorNumber: Int
    var date: String
    var startTime: String
    var endTime: String
    var reservationStatus: String
}

struct RoomInfo: Codable {
    var roomNumber: Int
    var floorNumber: Int
    var capacity: Int
}
