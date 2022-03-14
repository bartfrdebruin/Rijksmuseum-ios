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

	var imageURL: URL? { get }
	var title: String? { get }
	var description: String? { get }
	var maker: String? { get }

	func getCollectionDetail()
}

final class RijksDetailViewModel: RijksDetailViewModelProtocol {

	private(set) var state: State = .initial {
		didSet {
			refreshState()
		}
	}

	var refreshState: () -> Void = {}

	private var artObject: RijksDetailArtObject?

	var imageURL: URL? {
		return URL(string: artObject?.webImage.url ?? "")
	}

	var title: String? {
		return artObject?.title
	}

	var description: String? {
		return artObject?.description
	}

	var maker: String? {
		return artObject?.principalMakers.first?.name
	}

	private let objectNumber: String
	private let rijksRepository: RijksRepositoryProtocol

	init(objectNumber: String, rijksRepository: RijksRepositoryProtocol) {
		self.objectNumber = objectNumber
		self.rijksRepository = rijksRepository
	}

	func getCollectionDetail() {

		state = .loading

		rijksRepository.getCollectionDetail(
			objectNumber: objectNumber) { result in

				switch result {
				case .success(let artObject):

					self.artObject = artObject
					self.state = .result


				case .failure(let error):

					self.state = .error(error)
				}
			}
	}
}


