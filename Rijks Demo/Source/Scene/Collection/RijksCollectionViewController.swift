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

	// DataSource
	private lazy var dataSource = configureDataSource()

	// VM
	private var viewModel: RijksCollectionViewModelProtocol

	init(viewModel: RijksCollectionViewModelProtocol) {
		self.viewModel = viewModel
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
				self.configureSnapshot()
			case .error(let error):
				print("error: ", error)
			}
		}
	}
}

// MARK: - Diffable DataSource
extension RijksCollectionViewController {

	func configureDataSource() -> UICollectionViewDiffableDataSource<Int, RijksArtObject> {

		return UICollectionViewDiffableDataSource(collectionView: collectionView) {
			(collectionView, indexPath, artObject) -> UICollectionViewCell? in

			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RijksCollectionViewCell.identifier, for: indexPath) as! RijksCollectionViewCell

			cell.configure(artObject: artObject)
			return cell
		}
	}

	func configureSnapshot() {

		var snapshot = NSDiffableDataSourceSnapshot<Int, RijksArtObject>()
		snapshot.appendSections([1])

		snapshot.appendItems(viewModel.artObjects)
		dataSource.apply(snapshot)
	}

	func appendSnapshot() {

//		var snapshot = self.dataSource.snapshot()
//		snapshot.appendItems(viewModel.duplicateSource())
//		dataSource.apply(snapshot)
	}
}

// MARK: - UI
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

		collectionView.dataSource = dataSource
		collectionView.delegate = self
		collectionView.register(RijksCollectionViewCell.self,
								forCellWithReuseIdentifier: RijksCollectionViewCell.identifier)
	}
}

extension RijksCollectionViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		return CGSize(width: view.bounds.width, height: 100)
	}
}

// MARK: - UICollectionViewDelegate
extension RijksCollectionViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


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
