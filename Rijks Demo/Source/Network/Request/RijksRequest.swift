//
//  RijksRequest.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol RijksRequestProtocol {

	func getCollection(completion: @escaping (_ result: Result<RijksCollectionResponse, Error>) -> Void)
	func getCollectionDetail(objectNumber: String, completion: @escaping (_ result: Result<RijksDetailResponse, Error>) -> Void)
}

final class RijksRequest: RijksRequestProtocol {

	private let networkManager: NetworkManager

	init(networkManager: NetworkManager) {
		self.networkManager = networkManager
	}

	func getCollection(completion: @escaping (Result<RijksCollectionResponse, Error>) -> Void) {

		networkManager.getCollection { response in

			switch response {
			case .success(let response):
				completion(.success(response))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func getCollectionDetail(objectNumber: String, completion: @escaping (Result<RijksDetailResponse, Error>) -> Void) {

		networkManager.getCollectionDetail(objectNumber: objectNumber,
										   completion: { response in

			switch response {
			case .success(let response):
				completion(.success(response))
			case .failure(let error):
				completion(.failure(error))
			}
		})
	}
}

