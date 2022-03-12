//
//  RijksDetailViewModel.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

protocol RijksDetailViewModelProtocol {

	var state: State { get }
	var refreshState: () -> Void { get set }

	func getCollectionDetail()
}

final class RijksDetailViewModel: RijksDetailViewModelProtocol {

	private(set) var state: State = .initial {
		didSet {
			refreshState()
		}
	}

	var refreshState: () -> Void = {}

	private let objectNumber: String
	private let rijksRepository: RijksRepositoryProtocol

	init(objectID: String, rijksRepository: RijksRepositoryProtocol) {
		self.objectNumber = objectID
		self.rijksRepository = rijksRepository
	}

	func getCollectionDetail() {

		state = .loading

		rijksRepository.getCollectionDetail(
			objectNumber: objectNumber) { result in

				switch result {
				case .success(let collectionDetail):

					self.state = .result

				case .failure(let error):

					self.state = .error(error)
				}
			}
	}
}


