//
//  RijksCollectionResponse.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

struct RijksCollectionResponse: Decodable {

	let count: Int
	let artObjects: [RijksArtObjectResponse]
}
