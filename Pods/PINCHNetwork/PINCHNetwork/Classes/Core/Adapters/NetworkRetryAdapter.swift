//
//  NetworkRetryAdapter.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 27/10/2020.
//

public typealias NetworkRequestRetryCompletion = (_ shouldRetry: Bool) -> Void

public protocol NetworkRetryAdapter {

	func retry(route: NetworkRoute,
			   manager: NetworkManager,
			   error: NetworkError,
			   retryCount: Int,
			   completion: @escaping NetworkRequestRetryCompletion)
}
