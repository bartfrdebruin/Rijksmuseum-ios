//
//  RijksDetailArtObject.swift
//  Rijks Demo
//
//  Created by Bart on 13/03/2022.
//

import Foundation

struct RijksDetailArtObject {

	let id: String
	let objectNumber: String
	let title: String
	let copyrightHolder: String?
	let webImage: RijksImage
	let titles: [String]
	let description: String?
	let objectTypes: [String]
	let objectCollection: [String]
	let makers: [RijksMaker]
	let principalMakers: [RijksMaker]
	let plaqueDescriptionDutch: String
	let documentation: [String]

	init(detailArtObjectResponse: RijksDetailArtObjectResponse) {

		self.id = detailArtObjectResponse.id
		self.objectNumber = detailArtObjectResponse.objectNumber
		self.title = detailArtObjectResponse.title
		self.copyrightHolder = detailArtObjectResponse.copyrightHolder
		self.webImage = RijksImage(imageResponse: detailArtObjectResponse.webImage)
		self.titles = detailArtObjectResponse.titles
		self.description = detailArtObjectResponse.description
		self.objectTypes = detailArtObjectResponse.objectTypes
		self.objectCollection = detailArtObjectResponse.objectCollection
		self.makers = detailArtObjectResponse.makers.map({ RijksMaker(makerResponse: $0)})
		self.principalMakers = detailArtObjectResponse.principalMakers.map({ RijksMaker(makerResponse: $0)})
		self.plaqueDescriptionDutch = detailArtObjectResponse.plaqueDescriptionDutch
		self.documentation = detailArtObjectResponse.documentation
	}
}
