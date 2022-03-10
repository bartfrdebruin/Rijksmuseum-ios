//
//  NetworkRoute.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public enum HTTPMethod: String {

	case GET
	case POST
	case PUT
	case PATCH
	case DELETE
}

public protocol NetworkRoute {

	var path: String { get }
	var method: HTTPMethod { get }
	var body: Data? { get }
	var queryParameters: [String: Any]? { get }
	var headers: [String: String]? { get }
}

// MARK: - Default properties
public extension NetworkRoute {

	var method: HTTPMethod {
		return .GET
	}

	var body: Data? {
		return nil
	}

	var queryParameters: [String: Any]? {
		return nil
	}

	var headers: [String: String]? {
		return nil
	}
}

// MARK: - Helpers
public extension NetworkRoute {

	/**
	 Create a URLRequest based on a route
	 */
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

			let queryItems = parameters.map { key, value in
				return URLQueryItem(name: key, value: "\(value)")
			}

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
		environment?.defaultHeaders?.forEach { header in
			request.setValue(header.value, forHTTPHeaderField: header.key)
		}

		// Add specific route headers
		headers?.forEach { header in
			request.setValue(header.value, forHTTPHeaderField: header.key)
		}

		return request
	}
}
