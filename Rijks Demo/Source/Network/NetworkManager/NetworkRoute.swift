//
//  NetworkRoute.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

enum HTTPMethod: String {
	case GET
	case POST
	case PUT
	case PATCH
	case DELETE
}

protocol NetworkRoute {
	var path: String { get }
	var method: HTTPMethod { get }
	var body: Data? { get }
	var queryParameters: [String: Any]? { get }
	var headers: [String: String]? { get }
}

// MARK: - Helpers
extension NetworkRoute {

	func createURLRequest(using environment: NetworkEnvironment?) throws -> URLRequest {

		// Base URL
		let baseURL = environment?.baseURL.absoluteString ?? ""

		// Make we have a valid base URL
		guard var components = URLComponents(string: baseURL + path) else {
			throw NetworkError.invalidRequest
		}
		
		// Add the query parameters
		if let queryParameters = queryParameters, !queryParameters.isEmpty {

			var parameters: [String: Any] = [:]

			queryParameters.forEach { tuple in
				parameters [tuple.key] = tuple.value
			}

			let queryItems = parameters.compactMap({ (key, value) -> URLQueryItem in
				return URLQueryItem(name: key, value: "\(value)")
			})

			components.queryItems = queryItems
		}

		// Make sure we still have a valid URL
		guard let url = components.url else {
			throw NetworkError.invalidRequest
		}

		// Create the request
		var request = URLRequest(url: url)

		request.httpMethod = method.rawValue
		request.httpBody = body

		// Add default headers
		if let headers = environment?.defaultHeaders, !headers.isEmpty {

			for header in headers.enumerated() {

				request.setValue(header.element.value, forHTTPHeaderField: header.element.key)
			}
		}

		// Add specific route headers
		if let headers = headers, !headers.isEmpty {

			for header in headers.enumerated() {

				request.setValue(header.element.value, forHTTPHeaderField: header.element.key)
			}
		}

		return request
	}
}
