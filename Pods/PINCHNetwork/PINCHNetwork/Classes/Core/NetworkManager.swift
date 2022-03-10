//
//  NetworkManager.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

open class NetworkManager {

	public static let `default` = NetworkManager()

	/**
	 The environment used to make requests throughout this instance
	 */
	public var environment: NetworkEnvironment?

	/**
	 The request provider used to make requests
	 */
	private var requestProvider: NetworkRequestProvider

	/**
	 The retry adapter to have a request retried on error
	 */
	private var retryAdapter: NetworkRetryAdapter?

	/**
	 Before a route is executed it is passed to the `routeAdapter`. At this moment modifications can be made like adding an access token. This can also be used to replace the `defaultHeaders` value in the `NetworkEnvironment`.
	 For easy modification you can use `var newRoute = ModifiableNetworkRoute(route: route)` or implement your own logic
	 */
	private var routeAdapter: NetworkRouteAdapter

	public init(environment: NetworkEnvironment? = nil,
				requestProvider: NetworkRequestProvider = URLSessionRequestProvider(),
				retryAdapter: NetworkRetryAdapter? = nil,
				routeAdapter: NetworkRouteAdapter? = nil) {

		self.environment = environment
		self.requestProvider = requestProvider
		self.retryAdapter = retryAdapter
		self.routeAdapter = routeAdapter ?? NetworkRouteAdapterID()
	}

	/**
	 Convenience method to request a response with the installed environment
	 */
	public func request(for route: NetworkRoute,
						completion: @escaping NetworkRequestCompletion) -> NetworkTask? {

		if let retryAdapter = retryAdapter {

			return retryingRequest(
				route: route,
				retryAdapter: retryAdapter,
				completion: completion
			)
		} else {

			return requestProvider.request(
				for: routeAdapter.modify(route: route),
				in: environment,
				completion: completion
			)
		}
	}
}

// MARK: - Retry functionality
extension NetworkManager {

	private func retryingRequest(route: NetworkRoute,
								 retryAdapter: NetworkRetryAdapter,
								 retryCount: Int = 0,
								 completion: @escaping NetworkRequestCompletion) -> NetworkTask? {

		let modifiedRoute = routeAdapter.modify(route: route)

		return requestProvider.request(
			for: modifiedRoute,
			in: environment
		) { [weak self] task, result in

			guard case let .failure(error) = result, let self = self else {

				completion(task, result)
				return
			}

			// Closure which gets executed whenever the retry adapter tells us
			let onRetry: NetworkRequestRetryCompletion = { shouldRetry in

				if shouldRetry,
				   let task = task,
				   let retryingTask = self.retryingRequest(
					   route: modifiedRoute,
					   retryAdapter: retryAdapter,
					   retryCount: retryCount + 1,
					   completion: completion
				   ) {

					task.resumeSubtask(retryingTask)
				} else {

					completion(task, result)
				}
			}

			retryAdapter.retry(
				route: modifiedRoute,
				manager: self,
				error: error,
				retryCount: retryCount,
				completion: onRetry
			)
		}
	}
}
