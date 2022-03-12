//
//  RijksMakerResponse.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

struct RijksMakerResponse: Decodable {

	let name: String
	let unFixedName: String
	let placeOfBirth: String
	let dateOfBirth: String
	let placeOfDeath: String
	let occupation: [String]
}
