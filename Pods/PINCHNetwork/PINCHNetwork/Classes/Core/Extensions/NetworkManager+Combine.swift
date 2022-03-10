//
//  NetworkManagerCombine.swift
//  PINCHNetwork
//
//  Created by Saren Inden on 05/01/2021.
//

import Combine

@available(iOS 13.0, *)
extension NetworkManager {

	/**
	 Request NetwerkResponse via a combine publisher
	 */
	public func requestPublisher(for route: NetworkRoute) -> AnyPublisher<NetworkResponse, Error> {

		var task: NetworkTask?

		return Future { promise in

			task = self.request(for: route) { _, result in

				switch result {
				case let .success(response):
					promise(.success(response))
				case let .failure(error):
					promise(.failure(error))
				}
			}

			task?.resume()

		}.handleEvents(receiveCancel: {
			task?.cancel()
		}).eraseToAnyPublisher()
	}

	/**
	 Request data via a combine publisher
	 */
	public func requestDataPublisher(for route: NetworkRoute) -> AnyPublisher<Data, Error> {

		return requestPublisher(for: route)
			.tryMap { response in

				guard let data = response.data else {
					throw NetworkError.noDataAvailable
				}

				return data
			}
			.eraseToAnyPublisher()
	}

	/**
	 RequestDecodable as a publisher
	 */
	public func requestDecodablePublisher<T: Decodable>(route: NetworkRoute,
														decoder: JSONDecoder? = nil) -> AnyPublisher<T, Error> {

		return requestDataPublisher(for: route)
			.decode(type: T.self, decoder: decoder ?? Self.decoder)
			.eraseToAnyPublisher()
	}

	/**
	 RequestDecodable as a publisher
	 */
	public func requestDecodablePublisher<T: Decodable>(route: NetworkRoute,
														type: T.Type,
														decoder: JSONDecoder? = nil) -> AnyPublisher<T, Error> {

		return requestDecodablePublisher(route: route, decoder: decoder)
	}
}
