//
//  RijksCollectionViewModel.swift.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol RijksCollectionViewModelProtocol {

	var artObjects: [RijksArtObject] { get }
	var state: State { get }
	var refreshState: () -> Void { get set }

	func getCollection()
}

enum State {
	case initial
	case loading
	case result
	case error(Error)
}

final class RijksCollectionViewModel: RijksCollectionViewModelProtocol {

	var artObjects: [RijksArtObject] = []

	private(set) var state: State = .initial {
		didSet {
			refreshState()
		}
	}

	var refreshState: () -> Void = {}

	private let rijksRepository: RijksRepositoryProtocol

	init(rijksRepository: RijksRepositoryProtocol) {
		self.rijksRepository = rijksRepository
	}

	func getCollection() {

		state = .loading

		rijksRepository.getCollection { result in

			switch result {
			case .success(let collection):

				self.artObjects = collection.artObjects
				self.state = .result

			case .failure(let error):
				self.state = .error(error)
			}
		}
	}
}
