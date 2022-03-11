//
//  RijksRequest.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation
import PINCHNetwork

protocol RijksRequest {

	@discardableResult
	func getCollection(completion: @escaping (_ task: NetworkTask?, _ result: Result<[RijksCollectionResponse], NetworkError>) -> Void) -> NetworkTask?

	@discardableResult
	func getCollectionDetail(objectNumber: String, completion: @escaping (_ task: NetworkTask?, _ result: Result<RijksDetailResponse, NetworkError>) -> Void) -> NetworkTask?
}

extension NetworkManager: RijksRequest {

	@discardableResult
	func getCollection(completion: @escaping (_ task: NetworkTask?, _ result: Result<[RijksCollectionResponse], NetworkError>) -> Void) -> NetworkTask? {

		let route = RijksRoute.collection
		let task = requestDecodable(for: route, completion: completion)
		task?.resume()
		return task
	}

	@discardableResult
	func getCollectionDetail(objectNumber: String, completion: @escaping (_ task: NetworkTask?, _ result: Result<RijksDetailResponse, NetworkError>) -> Void) -> NetworkTask? {

		let route = RijksRoute.detail(objectNumber: objectNumber)
		let task = requestDecodable(for: route, completion: completion)
		task?.resume()
		return task
	}
}
