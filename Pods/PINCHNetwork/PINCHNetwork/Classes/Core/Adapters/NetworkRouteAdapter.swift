//
//  NetworkRouteAdapter.swift
//  PINCHNetwork
//
//  Created by Saren Inden on 28/02/2022.
//

public protocol NetworkRouteAdapter {

	func modify(route: NetworkRoute) -> NetworkRoute
}

struct NetworkRouteAdapterID: NetworkRouteAdapter {

	func modify(route: NetworkRoute) -> NetworkRoute {
		return route
	}
}
