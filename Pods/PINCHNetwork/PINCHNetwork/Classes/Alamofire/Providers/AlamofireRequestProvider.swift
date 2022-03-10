//
//  AlamofireRequestProvider.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation
import Alamofire

open class AlamofireRequestProvider: NetworkRequestProvider {

	/// Alamofire session manager used to deal with networking
	public var sessionManager = SessionManager.default

	/// Validation can be overridden if required, defaults to nil
	/// Will use default validation is nil is applied
	public var validation: DataRequest.Validation?

	public init() { }

	/**
	 Default implementation to execute a specific request using the current Alamofire manager
	 */
	public func request(for route: NetworkRoute,
						in environment: NetworkEnvironment?,
						completion: @escaping NetworkRequestCompletion) -> NetworkTask? {

		let dataRequest: DataRequest

		do {

			// Based on the type of route, choose how to build the request
			// When using the AlamofireRoute, it will use the Alamofire parameter encoding
			if let route = route as? AlamofireRoute {

				dataRequest = try route.createDataRequest(using: environment, sessionManager: sessionManager)
			} else {

				let request = try route.createURLRequest(using: environment)
				dataRequest = sessionManager.request(request)
			}
		} catch {

			completion(nil, .failure(NetworkError.unknownError(error)))
			return nil
		}

		var task: NetworkTask?

		dataRequest.responseData { (response) in

			if let error = response.error {

				// If validation went wrong, this will already be a known error
				if let error = error as? NetworkError {
					completion(task, .failure(error))
				} else {
					completion(task, .failure(NetworkError.unknownError(error)))
				}

				return
			}

			guard let request = dataRequest.request, let httpResponse = response.response else {

				completion(task, .failure(NetworkError.invalidRequest))
				return
			}

			let networkResponse = NetworkResponse(request: request, response: httpResponse, data: response.data)
			completion(task, .success(networkResponse))
		}.validate(validate)

		task = AlamofireNetworkTask(task: dataRequest)

		return task
	}

	private func validate(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Request.ValidationResult {

		// Checks if we have custom validation
		if let validation = validation {

			return validation(request, response, data)
		}

		// Resorts to default implementation if not
		guard response.validate() else {

			let statusError = NetworkStatusError(code: response.getStatusCode(), data: data)
			return .failure(NetworkError.unexpectedStatus(statusError))
		}

		return .success
	}
}
