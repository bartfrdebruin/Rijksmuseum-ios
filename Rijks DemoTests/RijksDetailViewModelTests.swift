//
//  RijksDetailViewModelTests.swift
//  Rijks DemoTests
//
//  Created by Bart on 14/03/2022.
//

import XCTest

@testable import Rijks_Demo

final class RijksDetailViewModelTests: XCTestCase {

	func testArtObjectPropertiesAreNotNil() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksDetailViewModel(
			objectNumber: "",
			rijksRepository: mockRepository)

		// When
		viewModel.getCollectionDetail()

		// Then
		XCTAssertNotNil(viewModel.title)
		XCTAssertNotNil(viewModel.imageURL)
		XCTAssertNotNil(viewModel.description)
		XCTAssertNotNil(viewModel.maker)
	}

	func testArtObjectNumberMatchesFetchedNumber() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksDetailViewModel(
			objectNumber: "AK-MAK-187",
			rijksRepository: mockRepository)

		// When
		viewModel.getCollectionDetail()

		if let artObjectNumber = viewModel.artObjectNumber {

			// Then
			XCTAssertEqual(artObjectNumber, "AK-MAK-187")
		}
	}

	func testResultState() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksDetailViewModel(
			objectNumber: "AK-MAK-187",
			rijksRepository: mockRepository)

		// When
		viewModel.getCollectionDetail()

		// Then
		XCTAssertTrue(viewModel.state == .result)
	}

	func testErrorState() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .error)
		let viewModel = RijksDetailViewModel(
			objectNumber: "AK-MAK-187",
			rijksRepository: mockRepository)

		// When
		viewModel.getCollectionDetail()

		// Then
		XCTAssertTrue(viewModel.state == .error(MockError.mock))
	}
}
