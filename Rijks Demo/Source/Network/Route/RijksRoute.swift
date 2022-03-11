//
//  RijksRoute.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation
import PINCHNetwork

enum RijksRoute: NetworkRoute {

	case collection
	case detail(objectNumber: String)

	var path: String {
		switch self {
		case .collection:
			return "en/collection"
		case .detail(let objectNumber):
			return "en/collection\(objectNumber)"
		}
	}

	var method: HTTPMethod {

		switch self {
		case .collection, .detail:
			return .GET
		}
	}
}
