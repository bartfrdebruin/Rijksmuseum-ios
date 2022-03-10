//
//  NetworkRequestProvider.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public typealias NetworkRequestResult = Result<NetworkResponse, NetworkError>
public typealias NetworkRequestCompletion = (NetworkTask?, NetworkRequestResult) -> Void

public protocol NetworkRequestProvider {

	func request(for route: NetworkRoute,
				 in environment: NetworkEnvironment?,
				 completion: @escaping NetworkRequestCompletion) -> NetworkTask?
}
