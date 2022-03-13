//
//  RijksDetailArtObjectResponse.swift
//  Rijks Demo
//
//  Created by Bart on 13/03/2022.
//

import Foundation

struct RijksDetailArtObjectResponse: Decodable {

	let id: String
	let objectNumber: String
	let title: String
	let copyrightHolder: String?
	let webImage: RijksImageResponse
	let titles: [String]
	let description: String?
	let objectTypes: [String]
	let objectCollection: [String]
	let makers: [RijksMakerResponse]
	let principalMakers: [RijksMakerResponse]
	let plaqueDescriptionDutch: String
	let documentation: [String]
}
