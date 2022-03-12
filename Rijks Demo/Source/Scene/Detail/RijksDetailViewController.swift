//
//  RijksDetailViewController.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import UIKit

final class RijksDetailViewController: UIViewController {

	// VM
	private var viewModel: RijksDetailViewModelProtocol

	init(viewModel: RijksDetailViewModelProtocol) {
		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .blue
		viewModel.getCollectionDetail()
	}
}

// MARK: - Factory
extension RijksDetailViewController {

	static func make(objectNumber: String) -> RijksDetailViewController {

		let networkManager = NetworkManager(environment: RijksEnvironment())
		let repository = RijksRepository(networkManager: networkManager)
		let viewModel = RijksDetailViewModel(objectID: objectID, rijksRepository: repository)

		return RijksDetailViewController(viewModel: viewModel)
	}
}
