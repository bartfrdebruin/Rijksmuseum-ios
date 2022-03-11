//
//  RijksEnvironment.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import PINCHNetwork

struct RijksEnvironment: NetworkEnvironment {

	var baseURL: URL {
		return URL(string: "https://data.rijksmuseum.nl/object-metadata/api/")!
	}

	var defaultHeaders: [String: String]? {

		var headers: [String: String] = [:]
		headers["key"] = "0fiuZFh4"
		
		return headers
	}
}
