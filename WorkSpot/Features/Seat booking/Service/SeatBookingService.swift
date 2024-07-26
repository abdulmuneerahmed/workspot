//
//  SeatBookingViewModel.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation 

protocol SeatingServiceable {
    @MainActor func getTotalSeat(date: Date) async -> Result<[TotalSeat], ApiError>
    @MainActor func getAllSeat() async -> Result<[SeatDetails], ApiError>
    @MainActor func makeAReservation(seatDetails: [String:Any]) async -> Result<ReservationSuccess, ApiError>
}

actor SeatingService: SeatingServiceable {
    
    private let service: HTTPClient
    init(service: HTTPClient = NetworkService.defaultService) {
        self.service = service
    }
    
    func getTotalSeat(date: Date) async -> Result<[TotalSeat], ApiError> {
        do {
            let result = try await service.sendRequest(endpoint: SeatSelection.totalSeat(date.ymdFormat), responseModel: [TotalSeat].self)
            return result
        } catch let apiError {
            return .failure(apiError as? ApiError ?? ApiError.undefinedError)
        }
    }
    
    func getAllSeat() async -> Result<[SeatDetails], ApiError> {
        do {
            let result = try await service.sendRequest(endpoint: SeatSelection.getAllSeat, responseModel: [SeatDetails].self)
            return result
        } catch let apiError {
            return .failure(apiError as? ApiError ?? ApiError.undefinedError)
        }
    }
    
    func makeAReservation(seatDetails: [String:Any]) async -> Result<ReservationSuccess, ApiError> {
        do {
            let result = try await service.sendRequest(endpoint: SeatSelection.bookSeat(seatDetails), responseModel: ReservationSuccess.self)
            return result
        } catch let apiError {
            return .failure(apiError as? ApiError ?? ApiError.undefinedError)
        }
    }
}

enum SeatSelection {
    case totalSeat(String)
    case getAllSeat
    case bookSeat([String:Any])
}

extension SeatSelection: EndpointProvider {
    
    var path: String {
        switch self {
        case .totalSeat:
            "/workspot/desk/total-seat"
        case .getAllSeat:
            "/workspot/desk/deskHistory"
        case .bookSeat:
            "/workspot/desk/seat-booking"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .totalSeat, .getAllSeat:
                .get
        case .bookSeat:
                .post
        }
        
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .totalSeat(let date):
            return [URLQueryItem(name: Parameters.date.keyValue, value: date)]
        case .getAllSeat:
            return nil
        case .bookSeat:
            return nil
        }
    }

    var body: [String : Any]? {
        switch self {
        case .bookSeat(let dictionary):
            return dictionary
        default:
            return nil
        }
    }

    var mockFile: String? {
        nil
    }
}
