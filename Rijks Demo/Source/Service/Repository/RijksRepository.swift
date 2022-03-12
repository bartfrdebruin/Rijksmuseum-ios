//
//  RijksRepository.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol RijksRepositoryProtocol {

	func getCollection(page: Int, completion: @escaping (_ result: Result<RijksCollection, Error>) -> Void)
	func getCollectionDetail(objectNumber: String, completion: @escaping (_ result: Result<RijksDetailResponse, Error>) -> Void)
}

final class RijksRepository: RijksRepositoryProtocol {

	private let rijksRequest: RijksRequestProtocol

	init(rijksRequest: RijksRequest) {
		self.rijksRequest = rijksRequest
	}

	func getCollection(
		page: Int,
		completion: @escaping (_ result: Result<RijksCollection, Error>) -> Void) {

		rijksRequest.getCollection(page: page) { response in

			switch response {
			case .success(let response):
				let collection = RijksCollection(collectionResponse: response)
				completion(.success(collection))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func getCollectionDetail(
		objectNumber: String,
		completion: @escaping (_ result: Result<RijksDetailResponse, Error>) -> Void) {

		rijksRequest.getCollectionDetail(objectNumber: objectNumber,
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
