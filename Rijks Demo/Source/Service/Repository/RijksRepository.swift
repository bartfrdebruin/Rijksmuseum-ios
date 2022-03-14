//
//  RijksRepository.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol RijksRepositoryProtocol {

	func getCollection(page: Int, completion: @escaping (_ result: Result<RijksCollection, Error>) -> Void)
	func getCollectionDetail(objectNumber: String, completion: @escaping (_ result: Result<RijksDetailArtObject, Error>) -> Void)
}

final class RijksRepository: RijksRepositoryProtocol {

	private let networkService: NetworkServiceProtocol

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}

	func getCollection(
		page: Int,
		completion: @escaping (_ result: Result<RijksCollection, Error>) -> Void) {

		networkService.getCollection(page: page) { response in

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
		completion: @escaping (_ result: Result<RijksDetailArtObject, Error>) -> Void) {

		networkService.getCollectionDetail(objectNumber: objectNumber,
											completion: { response in

			switch response {
			case .success(let response):
				let artObject = RijksDetailArtObject(detailArtObjectResponse: response.artObject)
				completion(.success(artObject))
			case .failure(let error):
				completion(.failure(error))
			}
		})
	}
}
