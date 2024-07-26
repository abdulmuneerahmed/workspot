//
//  HTTPClient.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> Result<T, ApiError>
}
