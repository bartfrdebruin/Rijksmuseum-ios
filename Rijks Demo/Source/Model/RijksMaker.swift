//
//  RijksMaker.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksMaker {

	let name: String
	let unFixedName: String
	let placeOfBirth: String?
	let dateOfBirth: String?
	let placeOfDeath: String?
	let occupation: [String]

	init(makerResponse: RijksMakerResponse) {
		self.name = makerResponse.name
		self.unFixedName = makerResponse.unFixedName
		self.placeOfBirth = makerResponse.placeOfBirth
		self.dateOfBirth = makerResponse.dateOfBirth
		self.placeOfDeath = makerResponse.placeOfDeath
		self.occupation = makerResponse.occupation
	}
}
