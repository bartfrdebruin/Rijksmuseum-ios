//
//  RijksCollectionViewModelTests.swift
//  Rijks DemoTests
//
//  Created by Bart on 14/03/2022.
//

import XCTest

@testable import Rijks_Demo

final class RijksCollectionViewModelTests: XCTestCase {

	func testSectionAreNotEmpty() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksCollectionViewModel(rijksRepository: mockRepository)

		// When
		viewModel.getCollection()

		// Then
		XCTAssertTrue(!viewModel.sections.isEmpty)
	}

	func testResultState() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksCollectionViewModel(rijksRepository: mockRepository)

		// When
		viewModel.getCollection()

		// Then
		XCTAssertTrue(viewModel.state == .result)
	}

	func testErrorState() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .error)
		let viewModel = RijksCollectionViewModel(rijksRepository: mockRepository)

		// When
		viewModel.getCollection()

		// Then
		XCTAssertTrue(viewModel.state == .error(MockError.mock))
	}

	func testPageIsUpdatedForPagination() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksCollectionViewModel(rijksRepository: mockRepository)

		// When
		for i in 1...4 {
			viewModel.getCollection()

			// Then
			XCTAssertEqual(i, mockRepository.page)
		}
	}

	func testSectionHeaderMatchesPaginationPages() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksCollectionViewModel(rijksRepository: mockRepository)

		// When
		for i in 0...4 {
			viewModel.getCollection()

			// Then
			let header = "Sectie \(viewModel.sections.count)"
			XCTAssertEqual(header, viewModel.sections[i].header)
		}
	}

	func testShouldLoadMoreCollections() {

		// Given
		let mockRepository = MockRijksRepository(mockState: .succes)
		let viewModel = RijksCollectionViewModel(rijksRepository: mockRepository)

		// When
		viewModel.getCollection()

		// Then
		XCTAssertTrue(viewModel.shouldLoadMoreCollections(for: IndexPath(item: 9, section: 0)))
		XCTAssertFalse(viewModel.shouldLoadMoreCollections(for: IndexPath(item: 8, section: 0)))
	}
}
