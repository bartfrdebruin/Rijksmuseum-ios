//
//  NetworkManager+Decodable.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 12/03/2019.
//

import Foundation

extension NetworkManager {

	/**
	Keep track of the decoder being used to decode data
	*/
	public static var decoder = JSONDecoder()

	/**
	Convenience method to request a mapped decodable instance
	*/
	public func requestDecodable<T: Decodable>(for route: NetworkRoute,
											   with decoder: JSONDecoder? = nil,
											   completion: @escaping (NetworkTask?, Result<T, NetworkError>) -> Void) -> NetworkTask? {

		// Use custom decoder if given
		let decoder = decoder ?? Self.decoder

		return request(for: route, completion: { (task, result) in

			completion(task, DecodableMapper(decoder: decoder).processDataResponse(result))
		})
	}
}
