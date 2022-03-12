//
//  RijksCollection.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksCollection {

	let count: Int
	let artObjects: [RijksArtObject]

	init(collectionResponse: RijksCollectionResponse) {
		self.count = collectionResponse.count
		self.artObjects = collectionResponse.artObjects.map({ RijksArtObject(artObjectResponse: $0 )})
	}
}
