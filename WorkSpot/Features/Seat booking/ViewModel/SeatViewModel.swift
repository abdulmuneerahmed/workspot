//
//  SeatViewModel.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

class SeatViewModel: ObservableObject {
    @Published var seats: [LocalSeat] = []
    
    init() {
        // Initialize with some example seats
        seats = Array(1...100).map { LocalSeat(seatNumber: $0, floorNumber: 0) }
    }
    
    func toggleSelection(for seat: LocalSeat) {
        if let index = seats.firstIndex(where: { $0.id == seat.id }) {
            seats[index].isSelected.toggle()
        }
    }
}
