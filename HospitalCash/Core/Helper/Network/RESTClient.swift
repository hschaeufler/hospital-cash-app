//
//  RESTClient.swift
//  HospitalCash
//
//  Created by hschaeufler on 29.01.23.
//  Source: https://github.com/hschaeufler/he4lth-app

import Foundation

class RESTClient {
    
    static let HEADER_FIELD_NAME_AUTHORISATION = "Authorization"
    static let HEADER_FIELD_NAME_CONTENT_TYPE = "Content-Type"
    static let CONTENT_TYPE_JSON = "application/json"

    
    func get<T: Decodable>(
        _ baseURL : String,
        path: String? = nil,
        queryParams: [String : String]? = nil,
        header: [String : String]? = nil,
        authToken: String? = nil) async throws -> T {
            return try await send(
                baseURL,
                path: path,
                httpMethod: HTTPMethod.GET,
                queryParams: queryParams,
                header: header,
                authToken: authToken
            )
        }
    
    func post<T: Decodable>(
        _ baseURL: String,
        path : String? = nil,
        httpBody: Codable? = nil,
        queryParams: [String : String]? = nil,
        header: [String : String]? = nil,
        authToken: String? = nil) async throws -> T {
            return try await send(
                baseURL,
                path: path,
                httpMethod: HTTPMethod.POST,
                httpBody: httpBody,
                queryParams: queryParams,
                header: header,
                authToken: authToken
            )
        }
    
    private func send<T: Decodable>(
        _ baseURL : String,
        path: String? = nil,
        httpMethod: HTTPMethod,
        httpBody: Codable? = nil,
        queryParams: [String : String]? = nil,
        header: [String : String]? = nil,
        authToken: String? = nil
    ) async throws -> T {
        // see: https://developer.apple.com/videos/play/wwdc2021/10095/
        // and: https://kean.blog/post/new-api-client
        
        let requestURL = "\(baseURL)\(path ?? "")"
        
        guard var urlComponent = URLComponents(string: requestURL) else {
            throw RESTClientError.invalidURL
        }
        
        // add QueryParams if they are set
        if let queryParams = queryParams {
            let queryItems = queryParams.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            urlComponent.queryItems = queryItems
        }

        guard let url = urlComponent.url else {
            throw RESTClientError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        // Add Request-Body and set Content-Type
        if httpBody != nil {
            urlRequest.httpBody = try toJSON(httpBody!)
            urlRequest.setValue(
                RESTClient.CONTENT_TYPE_JSON,
                forHTTPHeaderField: RESTClient.HEADER_FIELD_NAME_CONTENT_TYPE
            )
        }
        urlRequest.setValue(
            RESTClient.CONTENT_TYPE_JSON,
            forHTTPHeaderField: RESTClient.HEADER_FIELD_NAME_CONTENT_TYPE
        )
        
        // Add Header-Fields to Request
        if let header = header {
            for (fieldName, value) in header {
                urlRequest.setValue(value, forHTTPHeaderField: fieldName)
            }
        }
        
        // Add Auth-Token
        if let authToken = authToken {
            let bearerToken = "Bearer \(authToken)"
            urlRequest.setValue(bearerToken, forHTTPHeaderField: RESTClient.HEADER_FIELD_NAME_AUTHORISATION)
        }
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        try validate(urlResponse: response)
        
        return try fromJSON(data)
    }
    
    private func validate(urlResponse: URLResponse) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw RESTClientError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 {
            throw RESTClientError.unauthorized
        }
        
        guard (200..<300) ~= httpResponse.statusCode else {
            throw RESTClientError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    private func toJSON(_ object: Codable) throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        return data
    }
    
    private func fromJSON<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
