//
//  NetworkValidation.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 14/03/2019.
//

import Foundation

extension URLResponse {

	func validate() -> Bool {

		return NetworkStatusCode.successRange.contains(getStatusCode())
	}

	func getStatusCode() -> Int {

		return (self as? HTTPURLResponse)?.statusCode ?? NetworkStatusCode.ok
	}
}
