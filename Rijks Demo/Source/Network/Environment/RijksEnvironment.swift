//
//  RijksEnvironment.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

struct RijksEnvironment: NetworkEnvironment {

	var baseURL: URL {
		return URL(string: "https://www.rijksmuseum.nl/api/")!
	}

	var defaultHeaders: [String: String]? {
		return nil
	}
}
