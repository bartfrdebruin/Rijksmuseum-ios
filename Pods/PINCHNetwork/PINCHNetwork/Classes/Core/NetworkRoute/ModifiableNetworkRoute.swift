//
//  ModifiableNetworkRoute.swift
//  PINCHNetwork
//
//  Created by Saren Inden on 28/02/2022.
//

public struct ModifiableNetworkRoute: NetworkRoute {

	public var originalRoute: NetworkRoute?
	public var path: String
	public var method: HTTPMethod
	public var body: Data?
	public var queryParameters: [String: Any]?
	public var headers: [String: String]?

	public init(originalRoute: NetworkRoute? = nil,
				path: String,
				method: HTTPMethod = .GET,
				body: Data? = nil,
				queryParameters: [String: Any]? = nil,
				headers: [String: String]? = nil) {

		self.originalRoute = originalRoute
		self.path = path
		self.method = method
		self.body = body
		self.queryParameters = queryParameters
		self.headers = headers
	}

	public init(route: NetworkRoute) {

		self.originalRoute = route
		self.path = route.path
		self.method = route.method
		self.body = route.body
		self.queryParameters = route.queryParameters
		self.headers = route.headers
	}
}
