//
//  RijksImageResponse.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

struct RijksImageResponse: Decodable {

	let guid: String
	let offsetPercentageX: Float
	let offsetPercentageY: Float
	let width: Float
	let height: Float
	let url: String
}
