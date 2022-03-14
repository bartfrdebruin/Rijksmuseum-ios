//
//  RijksImage.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation

struct RijksImage: Hashable {

	let width: Float
	let height: Float
	let url: String

	init(imageResponse: RijksImageResponse) {

		self.width = imageResponse.width
		self.height = imageResponse.height
		self.url = imageResponse.url
	}
}
