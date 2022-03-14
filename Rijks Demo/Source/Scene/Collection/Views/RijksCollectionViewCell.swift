//
//  RijksCollectionViewCell.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import UIKit
import Kingfisher

extension RijksCollectionViewCell {

	struct State {
		let title: String
		let imageURL: URL?
	}
}

final class RijksCollectionViewCell: UICollectionViewCell {

	static let identifier = "RijksCollectionViewCell"

	private let horizontalStackView = UIStackView()
	private let imageView = UIImageView()
	private let titleLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: .zero)

		configureViewHierarchy()
		configureHorizontalStackView()
		configureImageView()
		configureTitleLabel()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		imageView.image = nil
		imageView.kf.cancelDownloadTask()
		titleLabel.text = nil
	}

	func configure(state: State) {

		titleLabel.text = state.title

		guard let url = state.imageURL else {
			imageView.isHidden = true
			return
		}

		imageView.loadURL(url, options: nil)
	}
}

// MARK: - Views
extension RijksCollectionViewCell {

	private func configureViewHierarchy() {

		contentView.addSubview(horizontalStackView)
		horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])

		horizontalStackView.addArrangedSubview(imageView)
		horizontalStackView.addArrangedSubview(titleLabel)
	}

	private func configureHorizontalStackView() {

		horizontalStackView.axis = .horizontal
		horizontalStackView.spacing = 5
		horizontalStackView.isLayoutMarginsRelativeArrangement = true
	}

	private func configureImageView() {

		imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
	}

	private func configureTitleLabel() {

		titleLabel.numberOfLines = 0
	}
}
