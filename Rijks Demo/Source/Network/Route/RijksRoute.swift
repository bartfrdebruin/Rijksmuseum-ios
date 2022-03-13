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
		switch self {
		case .collection(let page):
			return [
				"key": "0fiuZFh4",
				"p": page
			]
		case .detail:
			return [
				"key": "0fiuZFh4",
			]
		}
	}

	var headers: [String : String]? {
		return nil
	}

	case collection(page: Int)
	case detail(objectNumber: String)

	var path: String {
		switch self {
		case .collection:
			return "en/collection"
		case .detail(let objectNumber):
			return "en/collection/\(objectNumber)"
		}
	}

	var method: HTTPMethod {

		switch self {
		case .collection, .detail:
			return .GET
		}
	}
}
