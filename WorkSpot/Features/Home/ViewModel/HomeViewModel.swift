//
//  HomeViewModel.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var selectedDate: Date = Date()
    @Published var category: Screens = .desk
    private let seatingService: SeatingServiceable = SeatingService()
    @Published var totalSeats: [TotalSeat] = []
    @Published var allSeats: [SeatDetails] = []
    @Published var loadingData: Bool = false
    @Published var floor: Floors = .ten
    @Published var selectedSeat: Int = 0
    
    init() {}
    
    // Define a valid date range, allowing selection only for the next 3 weekdays
     var validDateRange: ClosedRange<Date> {
         let startDate = Date()
         let endDate = nextValidDate(from: startDate, daysToAdd: 3)
         return startDate...endDate
     }
     
     // Check if a date is valid (excluding weekends)
     func isValidDate(_ date: Date) -> Bool {
         let components = Calendar.current.dateComponents([.weekday], from: date)
         guard let weekday = components.weekday else { return false }
         return weekday != 1 && weekday != 7 // Exclude Sunday (1) and Saturday (7)
     }
     
     // Find the next valid date if the selected date is invalid
     func nextValidDate(from date: Date, daysToAdd: Int = 1) -> Date {
         var newDate = date
         var addedDays = 0
         
         while addedDays < daysToAdd {
             newDate = Calendar.current.date(byAdding: .day, value: 1, to: newDate)!
             if isValidDate(newDate) {
                 addedDays += 1
             }
         }
         
         return newDate
     }
    
    @MainActor
    func fetchAvailableSeats() async {
        loadingData = true
        Task.init {
            let result = await seatingService.getTotalSeat(date: selectedDate)
            switch result {
            case .success(let success):
                totalSeats = success
            case .failure(let failure):
                print("\(failure)")
            }
            loadingData = false
        }
        
    }
    
    @MainActor
    func getAvailableSeats() async {
        loadingData = true
        Task.init {
            let result = await seatingService.getAllSeat()
            switch result {
            case .success(let success):
                allSeats = success
            case .failure(let failure):
                print("\(failure)")
            }
            loadingData = false
        }
        
    }
    
    @MainActor
    func confirmReservation(_ type: ReservationType) async {
        loadingData = true
        Task.init {
            let result = await seatingService.makeAReservation(seatDetails: [
                Parameters.employId.keyValue: myEmpID,
                Parameters.seatNumber.keyValue: "\(selectedSeat)",
                Parameters.floorNumber.keyValue:"\(floor.keyValue)",
                Parameters.date.keyValue: "\(selectedDate.ymdFormat)",
                Parameters.reservationStatus.keyValue: "\(type.rawValue)"
            ])
            switch result {
            case .success(let success):
               print(success)
            case .failure(let failure):
                print("\(failure)")
            }
        }
        loadingData = false
    }
    
    func isSeatAvailable(_ seat: Int) -> Bool {
        !allSeats.contains {
            $0.floorNumber ==  floor.keyValue && $0.seatNumber == seat
            && $0.date == selectedDate.ymdFormat
        }
    }
}

enum Screens: Int, CaseIterable {
    case desk
    case meeting
    
    var value: String {
        switch self {
        case .desk:
            "Seats"
        case .meeting:
            "Meeting Rooms"
        }
    }
}

enum Floors: Int, CaseIterable {
    case ten
    case six
    case five
    
    var stingValue: String {
        switch self {
        case .ten:
            "10 th floor"
        case .six:
            "6 th floor"
        case .five:
            "5 th floor"
        }
    }
    
    var keyValue: Int {
        switch self {
        case .ten:
            10
        case .six:
            6
        case .five:
            5
        }
    }
}

enum ReservationType: String {
    case booked = "Booked"
    case reserved = "Reserved"
}
