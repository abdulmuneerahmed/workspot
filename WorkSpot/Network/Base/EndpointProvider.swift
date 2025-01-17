//
//  EndpointProvider.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import Foundation

protocol EndpointProvider {

    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var token: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }
}

extension EndpointProvider {

    var scheme: String { // 1
        return "https"
    }

    var baseURL: String { // 2
        return "student-management-system1-li3krvyppa-uc.a.run.app"
    }

    var token: String { //3
        return "" //TODO: will add token if it's required ApiConfig.shared.token?.value ?? ""
    }

    func asURLRequest() throws -> URLRequest { // 4

        var urlComponents = URLComponents() // 5
        urlComponents.scheme = scheme
        urlComponents.encodedHost = baseURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        urlComponents.path = path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw ApiError(statusCode: .invalidURL, errorCode: "ERROR-0", message: "URL error")
        }
        var urlRequest = URLRequest(url: url) // 6
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")

        if !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw ApiError(statusCode: .encodingFailed, errorCode: "ERROR-0", message: "Error encoding http body")
            }
        }
        return urlRequest
    }
}
