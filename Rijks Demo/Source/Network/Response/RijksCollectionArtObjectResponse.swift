//
//  RijksArtObjectResponse.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksCollectionArtObjectResponse: Decodable {
	let links: RijksLinksResponse
	let id: String
	let objectNumber: String
	let title: String
	let hasImage: Bool
	let principalOrFirstMaker: String
	let longTitle: String
	let showImage: Bool
	let permitDownload: Bool
	let webImage: RijksImageResponse
	let headerImage: RijksImageResponse
	let productionPlaces: [String]
}
