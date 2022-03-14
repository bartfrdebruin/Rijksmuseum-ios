//
//  MockRijksRepository.swift
//  Rijks DemoTests
//
//  Created by Bart on 14/03/2022.
//

import Foundation

@testable import Rijks_Demo

enum MockState {
	case error
	case succes
}

enum MockError: Error {
	case mock
}

final class MockRijksRepository: RijksRepositoryProtocol {

	private let mockState: MockState

	var page = 1

	init(mockState: MockState) {
		self.mockState = mockState
	}

	func getCollection(
		page: Int,
		completion: @escaping (Result<RijksCollection, Error>) -> Void) {

			switch mockState {
			case .error:
				completion(.failure(MockError.mock))
			case .succes:

				// Keep track of page to test pagination
				self.page = page

				do {
					let response = try JSONFileDecoder().decode(
						RijksCollectionResponse.self,
						from: "rijksCollectionResponse")
					completion(.success(RijksCollection(collectionResponse: response)))
				} catch {
					completion(.failure(error))
				}
			}
	}

	func getCollectionDetail(
		objectNumber: String,
		completion: @escaping (Result<RijksDetailArtObject, Error>) -> Void) {

			switch mockState {
			case .error:
				completion(.failure(MockError.mock))
			case .succes:

				do {
					let response = try JSONFileDecoder().decode(
						RijksDetailResponse.self,
						from: "rijksDetailResponse")
					completion(.success(RijksDetailArtObject(detailArtObjectResponse: response.artObject)))
				} catch {
					completion(.failure(error))
				}
			}
	}
}
