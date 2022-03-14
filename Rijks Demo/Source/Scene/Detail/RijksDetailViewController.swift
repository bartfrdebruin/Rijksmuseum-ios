//
//  RijksDetailViewController.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import UIKit

final class RijksDetailViewController: UIViewController {

	// UI
	private let activityIndicatorView = UIActivityIndicatorView()
	private let mainStackView = UIStackView()
	private let errorLabel = UILabel()

	// Detail Art
	private let imageView = UIImageView()
	private let textStackView = UIStackView()
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let makerLabel = UILabel()

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

		configureMainView()
		configureViewHierarchy()
		configureMainStackView()
		configureTextStackView()
		configureActivityIndicatorView()
		configureErrorLabel()
		configureImageView()
		configureTitleLabel()
		configureDescriptionLabel()
		configureMakerLabel()

		bindObservables()
		viewModel.getCollectionDetail()
	}

	private func bindObservables() {

		viewModel.refreshState = { [weak self] in

			guard let self = self else {
				return
			}

			DispatchQueue.main.async {

				switch self.viewModel.state {
				case .initial, .loading:
					self.activityIndicatorView.startAnimating()
				case .result:
					self.activityIndicatorView.stopAnimating()
					self.setViews()
				case .error(let error):
					self.activityIndicatorView.stopAnimating()
					self.errorLabel.text = error.localizedDescription
					self.errorLabel.isHidden = false
				}
			}
		}
	}

	private func setViews() {

		if let url = viewModel.imageURL {
			imageView.loadURL(url)
			imageView.isHidden = false
		}

		if let title = viewModel.title {
			titleLabel.text = title
			titleLabel.isHidden = false
		}

		if let description = viewModel.description {
			descriptionLabel.text = description
			descriptionLabel.isHidden = false
		}

		if let maker = viewModel.maker {
			makerLabel.text = maker
			makerLabel.isHidden = false
		}
	}
}

// MARK: - Views
extension RijksDetailViewController {

	private func configureMainView() {

		view.backgroundColor = .white
	}

	private func configureViewHierarchy() {

		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(mainStackView)
		NSLayoutConstraint.activate([
			mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
			mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
		])

		mainStackView.addArrangedSubview(activityIndicatorView)
		mainStackView.addArrangedSubview(errorLabel)
		mainStackView.addArrangedSubview(imageView)
		mainStackView.addArrangedSubview(textStackView)

		textStackView.addArrangedSubview(titleLabel)
		textStackView.addArrangedSubview(descriptionLabel)
		textStackView.addArrangedSubview(makerLabel)
	}

	private func configureActivityIndicatorView() {

		activityIndicatorView.hidesWhenStopped = true
		activityIndicatorView.style = .large
	}

	private func configureMainStackView() {

		mainStackView.axis = .vertical
		mainStackView.spacing = 5
	}

	private func configureTextStackView() {

		textStackView.axis = .vertical
		textStackView.spacing = 16
		textStackView.isLayoutMarginsRelativeArrangement = true
		textStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
			top: 0,
			leading: 16,
			bottom: 5,
			trailing: 16
		)
	}

	private func configureErrorLabel() {

		errorLabel.numberOfLines = 0
		errorLabel.isHidden = true
	}

	private func configureImageView() {

		imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/16).isActive = true
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.isHidden = true
	}

	private func configureTitleLabel() {

		titleLabel.numberOfLines = 0
		titleLabel.isHidden = true
	}

	private func configureDescriptionLabel() {

		descriptionLabel.numberOfLines = 0
		descriptionLabel.isHidden = true
	}

	private func configureMakerLabel() {

		makerLabel.numberOfLines = 0
		makerLabel.isHidden = true
	}
}

// MARK: - Factory
extension RijksDetailViewController {

	static func make(objectNumber: String) -> RijksDetailViewController {

		let networkService = NetworkService(environment: RijksEnvironment())
		let repository = RijksRepository(networkService: networkService)
		let viewModel = RijksDetailViewModel(
			objectNumber: objectNumber,
			rijksRepository: repository
		)

		return RijksDetailViewController(viewModel: viewModel)
	}
}
