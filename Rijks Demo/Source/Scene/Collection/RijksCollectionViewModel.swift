//
//  RijksCollectionViewModel.swift.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol RijksCollectionViewModelProtocol {

	var sections: [RijksCollectionSection] { get }
	var state: State { get }
	var refreshState: () -> Void { get set }

	func getCollection()
	func shouldLoadMoreCollections(for indexPath: IndexPath) -> Bool
}

enum State {
	case initial
	case loading
	case result
	case error(Error)
}

final class RijksCollectionViewModel: RijksCollectionViewModelProtocol {

	var sections: [RijksCollectionSection] = []

	private(set) var state: State = .initial {
		didSet {
			refreshState()
		}
	}

	var refreshState: () -> Void = {}

	// Pagination
	private var fetching: Bool = false
	private let maximumPageIndex = 9
	private var page = 1

	private let rijksRepository: RijksRepositoryProtocol

	init(rijksRepository: RijksRepositoryProtocol) {
		self.rijksRepository = rijksRepository
	}

	func getCollection() {

		guard !fetching else {
			return
		}

		fetching = true

		state = .loading

		rijksRepository.getCollection(page: page) { result in

			switch result {
			case .success(let collection):

				self.sections.append(RijksCollectionSection(
					headerState: "Sectie \(self.sections.count + 1)",
					items: collection.artObjects
				))

				self.state = .result
				self.page += 1
				self.fetching = false

			case .failure(let error):
				self.state = .error(error)
				self.fetching = false
			}
		}
	}

	func shouldLoadMoreCollections(for indexPath: IndexPath) -> Bool {

		return sections.count - 1 == indexPath.section && indexPath.item == maximumPageIndex
	}
}
