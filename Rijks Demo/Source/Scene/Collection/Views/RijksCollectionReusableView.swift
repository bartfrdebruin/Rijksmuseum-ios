//
//  RijksCollectionReusableView.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import UIKit

final class RijksCollectionReusableView: UICollectionReusableView {

	static let identifier = "RijksCollectionReusableView"

	private let titleLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)

		configureViewHierarchy()
		configureTitleLabel()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		titleLabel.text = nil
	}

	func configure(text: String) {

		titleLabel.text = text
	}
}

// MARK: - Views
extension RijksCollectionReusableView {

	private func configureViewHierarchy() {

		addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
	
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}

	private func configureTitleLabel() {

		titleLabel.numberOfLines = 1
	}
}
