//
//  RijksCollectionViewAdapterModel.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksCollectionSection {

	var header: String
	let items: [RijksCollectionArtObject]
	var count: Int { items.count }

	func item(atItemIndex index: Int) -> RijksCollectionArtObject {
		return items[index]
	}
}
