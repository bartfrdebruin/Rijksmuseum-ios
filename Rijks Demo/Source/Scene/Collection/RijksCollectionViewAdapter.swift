//
//  RijksCollectionViewAdapter.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation
import UIKit

final class RijksCollectionViewAdapter: NSObject {

	private var sections: [RijksCollectionSection] = []

	var selectedArtObject: ((RijksArtObject) -> Void)?
	var willDisplayIndexPath: ((IndexPath) -> Void)?

	func configure(_ collectionView: UICollectionView) {

		collectionView.register(
			RijksCollectionViewCell.self,
			forCellWithReuseIdentifier: RijksCollectionViewCell.identifier
		)

		collectionView.register(
			RijksCollectionReusableView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: RijksCollectionReusableView.identifier
		)

		collectionView.delegate = self
		collectionView.dataSource = self
	}

	func section(atSectionIndex index: Int) -> RijksCollectionSection {

		return sections[index]
	}

	func item(at indexPath: IndexPath) -> RijksArtObject {

		return section(atSectionIndex: indexPath.section)
			.item(atItemIndex: indexPath.item)
	}

	func setSections(_ sections: [RijksCollectionSection]) {

		self.sections = sections
	}
}

// MARK: UICollectionViewDelegate
extension RijksCollectionViewAdapter: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		collectionView.deselectItem(at: indexPath, animated: true)
		let item = item(at: indexPath)
		selectedArtObject?(item)
	}
}

// MARK: UICollectionViewDataSource
extension RijksCollectionViewAdapter: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {

		return sections.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection sectionIndex: Int) -> Int {

		return section(atSectionIndex: sectionIndex).count
	}

	func collectionView(_ collectionView: UICollectionView,
						viewForSupplementaryElementOfKind kind: String,
						at indexPath: IndexPath) -> UICollectionReusableView {

		guard kind == UICollectionView.elementKindSectionHeader else {
			fatalError()
		}

		let section = self.section(atSectionIndex: indexPath.section)

		guard let view = collectionView.dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: RijksCollectionReusableView.identifier,
			for: indexPath) as? RijksCollectionReusableView else {
				fatalError()
			}

		view.configure(text: section.header)
		return view
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: RijksCollectionViewCell.identifier,
			for: indexPath) as? RijksCollectionViewCell else {
			fatalError()
		}

		let item = item(at: indexPath)
		cell.configure(artObject: item)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

		willDisplayIndexPath?(indexPath)
	}
}
