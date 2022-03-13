//
//  NetworkManager.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

final class NetworkManager {

	private let environment: NetworkEnvironment

	private var dataTask: URLSessionDataTask?

	init(environment: NetworkEnvironment) {
		self.environment = environment
	}

	private func requestDecodable<T: Decodable>(route: NetworkRoute,
												completion: @escaping (Result<T, Error>) -> Void) {

		guard let request = try? route.createURLRequest(using: environment) else {
			completion(.failure(NetworkError.invalidRequest))
			return
		}

		dataTask?.cancel()

		dataTask = URLSession.shared.dataTask(with: request) { data, response, error in

			if let error = error {
				completion(.failure(error))
			}

			do {
				if let data = data {
					let model = try JSONDecoder().decode(T.self, from: data)
					completion(.success(model))
				}
			} catch let error {
				completion(.failure(error))
			}
		}

		dataTask?.resume()
	}
}

// MARK: Requests
extension NetworkManager: RijksRequestProtocol {

	func getCollection(
		page: Int,
		completion: @escaping (Result<RijksCollectionResponse, Error>) -> Void) {

		let route = RijksRoute.collection(page: page)
		requestDecodable(route: route, completion: completion)
	}

	func getCollectionDetail(
		objectNumber: String,
		completion: @escaping (Result<RijksDetailResponse, Error>) -> Void) {

		let route = RijksRoute.detail(objectNumber: objectNumber)
		requestDecodable(route: route, completion: completion)
	}
}
