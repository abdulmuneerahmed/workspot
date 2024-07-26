//
//  NetworkService.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation
actor NetworkService: HTTPClient {
    static let defaultService = NetworkService()
    private init() {}
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60 // seconds that a task will wait for data to arrive
        configuration.timeoutIntervalForResource = 300 // seconds for whole resource request to complete ,.
        return URLSession(configuration: configuration)
    }
    
    func sendRequest<T>(endpoint: any EndpointProvider, responseModel: T.Type) async throws -> Result<T, ApiError> where T : Decodable {
        do {
            let (data, response) = try await session.data(for: endpoint.asURLRequest())
            return try self.manageResponse(data: data, response: response)
        } catch let error as ApiError { // 3
            throw error
        } catch let error {
            throw ApiError(
                errorCode: "ERROR-\(error)",
                message: "Unknown API error \(error.localizedDescription)"
            )
        }
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> Result<T, ApiError> {
            guard let response = response as? HTTPURLResponse else {
                throw ApiError(
                    statusCode: .badResponse,
                    errorCode: "ERROR-0",
                    message: "Invalid HTTP response"
                )
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedData)
                } catch let error{
                    print("‼️", error)
                    throw ApiError(
                        errorCode:"\(error)",
                        message: error.localizedDescription
                    )
                }
            case 404:
                return .failure(.init(statusCode: .notFound, errorCode: "ERROR-\(response.statusCode)", message: "\(response.description)"))
            default:
                guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
                    throw ApiError(
                        statusCode: StatusCode(rawValue: response.statusCode) ?? .undefinedError,
                        errorCode: "ERROR-\(response.statusCode)",
                        message: "Unknown backend error"
                    )
                }
                return .failure(ApiError(
                    statusCode: StatusCode(rawValue: response.statusCode) ?? .undefinedError,
                    errorCode: "\(response.statusCode)-\(decodedError.errorCode)",
                    message: decodedError.message
                ))
            }
        }
}
