//
//  RijksRepositoryTests.swift
//  Rijks DemoTests
//
//  Created by Bart on 14/03/2022.
//

import XCTest

@testable import Rijks_Demo

final class RijksRepositoryTests: XCTestCase {

	func testCollectionResponseIsNotEmpty() {

		// Given
		let mockNetworkService = MockNetworkService(mockState: .succes)
		let repository = RijksRepository(networkService: mockNetworkService)

		// When
		repository.getCollection(
			page: 1) { result in

				// Then
				switch result {
				case .success(let response):
					XCTAssertFalse(response.artObjects.isEmpty)
				case .failure(let error):
					XCTAssertNil(error)
				}
			}
	}

	func testCollectionErrorIsNotEmpty() {

		// Given
		let mockNetworkService = MockNetworkService(mockState: .error)
		let repository = RijksRepository(networkService: mockNetworkService)

		// When
		repository.getCollection(
			page: 1) { result in

				// Then
				switch result {
				case .success(let response):
					XCTAssertNil(response)
				case .failure(let error):
					XCTAssertNotNil(error)
				}
			}
	}

	func testDetailResponseIsNotEmpty() {

		// Given
		let mockNetworkService = MockNetworkService(mockState: .succes)
		let repository = RijksRepository(networkService: mockNetworkService)

		// When
		repository.getCollectionDetail(
			objectNumber: "AK-MAK-187",
			completion: { result in

				// Then
				switch result {
				case .success(let response):
					XCTAssertNotNil(response)
				case .failure(let error):
					XCTAssertNil(error)
				}
			})
	}

	func testDetailErrorIsNotEmpty() {

		// Given
		let mockNetworkService = MockNetworkService(mockState: .error)
		let repository = RijksRepository(networkService: mockNetworkService)

		// When
		repository.getCollectionDetail(
			objectNumber: "AK-MAK-187",
			completion: { result in

				// Then
				switch result {
				case .success(let response):
					XCTAssertNil(response)
				case .failure(let error):
					XCTAssertNotNil(error)
				}
			})
	}

	func testArtObjectNumberMatchesFetchedNumber() throws {

		// Given
		let mockNetworkService = MockNetworkService(mockState: .succes)
		let repository = RijksRepository(networkService: mockNetworkService)

		// When
		repository.getCollectionDetail(
			objectNumber: "AK-MAK-187",
			completion: { result in

				if let collectionDetail = try? result.get() {
					XCTAssertEqual(collectionDetail.objectNumber, "AK-MAK-187")
				}
			})
	}
}
