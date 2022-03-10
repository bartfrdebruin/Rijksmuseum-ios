//
//  AlamofireRouter.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation
import Alamofire

public protocol AlamofireRoute: NetworkRoute {

	var parameterEncoding: ParameterEncoding { get }
	var parameters: Parameters? { get }
}

// MARK: - Default properties
public extension AlamofireRoute {

	/**
	Body should not be used in any case when using the AlamofireRoute
	*/
	var body: Data? {
		fatalError("Don't use the body to create a request. Use `parameters` and `parameterEncoding` instead.")
	}

	var parameters: Parameters? {
		return nil
	}

	var parameterEncoding: ParameterEncoding {
		return URLEncoding.default
	}
}

// MARK: - Helpers
public extension AlamofireRoute {

	/**
	Create a URLRequest based on a route
	*/
	func createDataRequest(using environment: NetworkEnvironment?,
						   sessionManager: SessionManager) throws -> DataRequest {

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

			let queryItems = parameters.map { key, value -> URLQueryItem in
				return URLQueryItem(name: key, value: "\(value)")
			}

			components.queryItems = queryItems
		}

		// Add default headers
		var routeHeaders = headers ?? [:]

		environment?.defaultHeaders?.forEach { header in
			routeHeaders[header.key] = header.value
		}

		// Make sure we still have a valid URL
		guard let url = components.url else {
			throw NetworkError.invalidRequest
		}

		let convertedMethod = Alamofire.HTTPMethod(rawValue: method.rawValue) ?? .get
		return sessionManager.request(url,
									  method: convertedMethod,
									  parameters: parameters,
									  encoding: parameterEncoding,
									  headers: routeHeaders)
	}
}
