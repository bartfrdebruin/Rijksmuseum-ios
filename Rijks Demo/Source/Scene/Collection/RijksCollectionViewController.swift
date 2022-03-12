//
//  RijksCollectionViewController.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import UIKit

final class RijksCollectionViewController: UIViewController {

	// UI
	private let activityIndicatorView = UIActivityIndicatorView()
	private let collectionView: UICollectionView
	private let errorLabel = UILabel()
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

		configureMainView()
		configureViewHierarchy()
		configureActivityIndicatorView()
		configureCollectionView()
		configureErrorLabel()
		bindObservables()
		bindAdapterHandlers()
		viewModel.getCollection()
	}

	private func bindObservables() {

		viewModel.refreshState = { [weak self] in

			guard let self = self else {
				return
			}

			DispatchQueue.main.async {

				switch self.viewModel.state {
				case .initial, .loading:

					if self.viewModel.sections.isEmpty {
						self.activityIndicatorView.startAnimating()
					}
				case .result:

					self.activityIndicatorView.stopAnimating()
					self.collectionView.isHidden = false
					self.adapter.setSections(self.viewModel.sections)
					self.collectionView.reloadData()

				case .error(let error):

					self.activityIndicatorView.stopAnimating()
					self.collectionView.isHidden = true
					self.errorLabel.isHidden = false
					self.errorLabel.text = error.localizedDescription
				}
			}
		}
	}
}

// MARK: - Views
extension RijksCollectionViewController {

	private func configureMainView() {

		view.backgroundColor = .white
	}

	private func configureViewHierarchy() {

		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(activityIndicatorView)
		NSLayoutConstraint.activate([
			activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])

		errorLabel.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(errorLabel)
		NSLayoutConstraint.activate([
			errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
			errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			errorLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
		])
	}

	private func configureActivityIndicatorView() {

		activityIndicatorView.hidesWhenStopped = true
		activityIndicatorView.style = .large
	}

	private func configureCollectionView() {

		collectionView.isHidden = true
		adapter.configure(collectionView)

		if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {

			layout.minimumLineSpacing = 10
			layout.itemSize = CGSize(width: view.bounds.width, height: 100)
			layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 30)
		}
	}

	private func configureErrorLabel() {

		errorLabel.numberOfLines = 0
		errorLabel.isHidden = true
	}
}

// MARK: - Adapter
extension RijksCollectionViewController {

	private func bindAdapterHandlers() {

		adapter.willDisplayIndexPath = { [weak self] indexPath in

			guard let self = self else {
				return
			}

			if self.viewModel.shouldLoadMoreCollections(for: indexPath) {

				self.viewModel.getCollection()
			}
		}

		adapter.selectedArtObject = { [weak self] object in

			guard let self = self else {
				return
			}


		}
	}
}

// MARK: - Factory
extension RijksCollectionViewController {

	static func make() -> RijksCollectionViewController {

		let networkManager = NetworkManager(environment: RijksEnvironment())
		let repository = RijksRepository(networkManager: networkManager)
		let viewModel = RijksCollectionViewModel(rijksRepository: repository)

		return RijksCollectionViewController(viewModel: viewModel)
	}
}
