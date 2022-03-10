//
//  URLSessionRequestProvider.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public class URLSessionRequestProvider: NetworkRequestProvider {

	private let urlSession: URLSession

	public init(configuration: URLSessionConfiguration = .default) {

		urlSession = URLSession(configuration: configuration)
	}

	/**
	Default implementation to execute a specific request using the current URLSession
	*/
	public func request(for route: NetworkRoute,
						in environment: NetworkEnvironment?,
						completion: @escaping NetworkRequestCompletion) -> NetworkTask? {

		let request: URLRequest

		do {

			request = try route.createURLRequest(using: environment)
		} catch {

			completion(nil, .failure(NetworkError.unknownError(error)))

			return nil
		}

		var task: NetworkTask?

		// Create request provider (for demonstration purposes)
		let urlSessionTask = urlSession.dataTask(with: request) { (data, response, error) in

			if let error = error {

				completion(task, .failure(NetworkError.unknownError(error)))
				return
			}

			guard let response = response as? HTTPURLResponse else {

				completion(task, .failure(NetworkError.invalidRequest))
				return
			}

			guard response.validate() else {

				let statusError = NetworkStatusError(code: response.getStatusCode(), data: data)
				completion(task, .failure(NetworkError.unexpectedStatus(statusError)))
				return
			}

			let networkResponse = NetworkResponse(request: request, response: response, data: data)
			completion(task, .success(networkResponse))
		}

		task = URLSessionNetworkTask(task: urlSessionTask)

		return task
	}
}
