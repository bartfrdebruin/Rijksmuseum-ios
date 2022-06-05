//
//  NetworkService.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol NetworkServiceProtocol {

	func getCollection(page: Int) async -> Result<RijksCollectionResponse, Error>
	func getCollectionDetail(objectNumber: String) async -> Result<RijksDetailResponse, Error>
}

final class NetworkService {

	private let environment: NetworkEnvironment
	private var dataTask: URLSessionDataTask?

	init(environment: NetworkEnvironment) {
		self.environment = environment
	}
	
	private func requestDecodable<T: Decodable>(route: NetworkRoute) async -> (Result<T, Error>) {

		guard let request = try? route.createURLRequest(using: environment) else {
			return .failure(NetworkError.invalidRequest)
		}
		
		do {
			let response = try await URLSession.shared.data(for: request)
			let model = try JSONDecoder().decode(T.self, from: response.0)
			return .success(model)
			
		} catch let error {
			return .failure(error)
		}
	}
}

// MARK: Requests
extension NetworkService: NetworkServiceProtocol {

	func getCollection(page: Int) async -> Result<RijksCollectionResponse, Error> {

		let route = RijksRoute.collection(page: page)
		return await requestDecodable(route: route)
	}

	func getCollectionDetail(
		objectNumber: String) async -> Result<RijksDetailResponse, Error> {
	
		let route = RijksRoute.detail(objectNumber: objectNumber)
		return await requestDecodable(route: route)
	}
}
