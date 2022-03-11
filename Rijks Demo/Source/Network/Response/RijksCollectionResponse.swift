//
//  RijksCollectionResponse.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

struct RijksCollectionResponse: Decodable {

	struct LinksResponse: Decodable {
		let `self`: String
		let web: String
	}

	struct ArtObjectResponse: Decodable {

		let links: LinksResponse
		let id: String
		let objectNumber: String
		let title: String
		let hasImage: Bool
		let principalOrFirstMaker: String
		let longTitle: String
		let showImage: Bool
		let permitDownload: Bool
		let webImageReponse: RijksImageResponse
		let headerImageResponse: RijksImageResponse
		let productionPlaces: [String]
	}

	let count: Int
	let artObjects: [ArtObjectResponse]
}
