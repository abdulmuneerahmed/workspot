//
//  APIError.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

enum StatusCode: Int {
    case success = 200
    case tokenExpired = 405
    case unauthorised = 401
    case notFound = 404
    case badRequest = 400
    case invalidURL = 402
    case badResponse = 501
    case encodingFailed = 300
    case undefinedError = 600
}

struct ApiError: Error {

    var statusCode: StatusCode!
    let errorCode: String
    var message: String

    init(statusCode: StatusCode = .undefinedError, errorCode: String, message: String) {
        self.statusCode = statusCode
        self.errorCode = errorCode
        self.message = message
    }

    var errorCodeNumber: String {
        let numberString = errorCode.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return numberString
    }

    private enum CodingKeys: String, CodingKey {
        case errorCode
        case message
    }
    
    static var undefinedError: ApiError {
        .init(errorCode: "Error-606", message: "error while catching in service layer")
    }
}

extension ApiError: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try container.decode(String.self, forKey: .errorCode)
        message = try container.decode(String.self, forKey: .message)
    }
}
