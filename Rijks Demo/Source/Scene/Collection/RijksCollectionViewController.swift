//
//  RijksCollectionViewController.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import UIKit

final class RijksCollectionViewController: UIViewController {

	// UI
	private let collectionView: UICollectionView
	private let adapter: RijksCollectionViewAdapter

	// VM
	private var viewModel: RijksCollectionViewModelProtocol

	init(viewModel: RijksCollectionViewModelProtocol) {
		self.viewModel = viewModel
		self.adapter = RijksCollectionViewAdapter()
		self.collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: UICollectionViewFlowLayout()
		)

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		configureViewHierarchy()
		configureCollectionView()
		bindObservables()
		bindAdapterHandlers()
		viewModel.getCollection()
	}

	private func bindObservables() {

		viewModel.refreshState = {

			switch self.viewModel.state {
			case .initial:
				print("loading: ")
			case .loading:
				print("loading: ")
			case .result:
				
				self.adapter.setSections(self.viewModel.sections)

				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			case .error(let error):
				print("error: ", error)
			}
		}
	}
}

// MARK: - UICollectionView
extension RijksCollectionViewController {

	private func configureViewHierarchy() {

		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	private func configureCollectionView() {

		adapter.configure(collectionView)
		if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {

			layout.minimumLineSpacing = 10
			layout.itemSize = CGSize(width: view.bounds.width, height: 100)
			layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 30)
		}
	}

	private func bindAdapterHandlers() {

		adapter.willDisplayIndexPath = { [weak self] indexPath in

			guard let self = self else {
				return
			}

			if self.viewModel.shouldLoadMoreCollections(for: indexPath) {

				self.viewModel.getCollection()
			}
		}
	}
}

// MARK: - Factory
extension RijksCollectionViewController {

	static func make() -> RijksCollectionViewController {

		let networkManager = NetworkManager(environment: RijksEnvironment())
		let rijksRequest = RijksRequest(networkManager: networkManager)
		let repository = RijksRepository(rijksRequest: rijksRequest)
		let viewModel = RijksCollectionViewModel(rijksRepository: repository)

		return RijksCollectionViewController(viewModel: viewModel)
	}
}
