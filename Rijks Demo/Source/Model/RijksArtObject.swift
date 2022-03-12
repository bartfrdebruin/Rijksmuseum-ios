//
//  RijksArtObject.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksArtObject: Hashable {

	static func == (lhs: RijksArtObject, rhs: RijksArtObject) -> Bool {
		return lhs.id == rhs.id
	}

	let link: String
	let id: String
	let objectNumber: String
	let title: String
	let hasImage: Bool
	let principalOrFirstMaker: String
	let longTitle: String
	let showImage: Bool
	let permitDownload: Bool
	let webImage: RijksImage
	let headerImage: RijksImage
	let productionPlaces: [String]

	init(artObjectResponse: RijksArtObjectResponse) {
		self.link = artObjectResponse.links.web
		self.id = artObjectResponse.id
		self.objectNumber = artObjectResponse.objectNumber
		self.title = artObjectResponse.title
		self.hasImage = artObjectResponse.hasImage
		self.principalOrFirstMaker = artObjectResponse.principalOrFirstMaker
		self.longTitle = artObjectResponse.longTitle
		self.showImage = artObjectResponse.showImage
		self.permitDownload = artObjectResponse.permitDownload
		self.webImage = RijksImage(imageResponse: artObjectResponse.webImage)
		self.headerImage = RijksImage(imageResponse: artObjectResponse.headerImage)
		self.productionPlaces = artObjectResponse.productionPlaces
	}
}
