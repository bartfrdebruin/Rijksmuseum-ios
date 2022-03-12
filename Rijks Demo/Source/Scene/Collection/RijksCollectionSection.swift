//
//  RijksCollectionViewAdapterModel.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksCollectionSection: Equatable {

	var header: String
	let items: [RijksArtObject]
	var count: Int { items.count }

	func item(atItemIndex index: Int) -> RijksArtObject {
		return items[index]
	}
}
