//
//  RijksCollection.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksCollection {

	let count: Int
	let artObjects: [RijksCollectionArtObject]

	init(collectionResponse: RijksCollectionResponse) {

		self.count = collectionResponse.count
		self.artObjects = collectionResponse.artObjects.map({ RijksCollectionArtObject(artObjectResponse: $0 )})
	}
}
