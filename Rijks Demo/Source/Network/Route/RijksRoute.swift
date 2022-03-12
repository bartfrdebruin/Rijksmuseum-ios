//
//  RijksRoute.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

enum RijksRoute: NetworkRoute {

	var body: Data? {
		return nil
	}

	var queryParameters: [String : Any]? {
		return ["key": "0fiuZFh4"]
	}

	var headers: [String : String]? {
		return ["key": "0fiuZFh4"]
	}

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
