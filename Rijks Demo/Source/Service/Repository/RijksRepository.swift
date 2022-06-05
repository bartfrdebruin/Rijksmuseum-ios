//
//  RijksRepository.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol RijksRepositoryProtocol {

	func getCollection(page: Int) async -> Result<RijksCollection, Error>
	func getCollectionDetail(objectNumber: String) async -> Result<RijksDetailArtObject, Error>
}

final class RijksRepository: RijksRepositoryProtocol {
	
	private let networkService: NetworkServiceProtocol

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}

	func getCollectionDetail(objectNumber: String) async -> Result<RijksDetailArtObject, Error> {
		
		let result = await networkService.getCollectionDetail(objectNumber: objectNumber)
		
		switch result {
		case .success(let detail):
			return .success(RijksDetailArtObject(detailArtObjectResponse: detail.artObject))
		case .failure(let error):
			return .failure(error)
		}
	}
	
	
	func getCollection(page: Int) async -> Result<RijksCollection, Error> {

		let result = await networkService.getCollection(page: page)
		
		switch result {
		case .success(let collection):
			return .success(RijksCollection(collectionResponse: collection))
		case .failure(let error):
			return .failure(error)
		}
	}
}
