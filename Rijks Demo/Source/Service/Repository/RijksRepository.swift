//
//  RijksRepository.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol RijksRepositoryProtocol {

	func getCollection(completion: @escaping (_ result: Result<[RijksCollectionResponse], Error>) -> Void)
	func getCollectionDetail(objectNumber: String, completion: @escaping (_ result: Result<RijksDetailResponse, Error>) -> Void)
}

final class RijksRepository: RijksRepositoryProtocol {

	private let rijksRequest: RijksRequest

	init(rijksRequest: RijksRequest) {
		self.rijksRequest = rijksRequest
	}

	func getCollection(completion: @escaping (_ result: Result<[RijksCollectionResponse], Error>) -> Void) {

		rijksRequest.getCollection { task, result in

			switch result {
			case .success(let response):
				completion(.success(response))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func getCollectionDetail(objectNumber: String, completion: @escaping (_ result: Result<RijksDetailResponse, Error>) -> Void) {

		rijksRequest.getCollectionDetail(objectNumber: objectNumber, completion: { task, result in

			switch result {
			case .success(let response):
				completion(.success(response))
			case .failure(let error):
				completion(.failure(error))
			}
		})
	}
}
