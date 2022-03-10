//
//  NetworkError.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public struct NetworkStatusError {

	public let code: Int
	public let data: Data?

	public init(code: Int, data: Data?) {

		self.code = code
		self.data = data
	}
}

public enum NetworkError: LocalizedError {

	case unexpectedStatus(NetworkStatusError)
	case invalidRequest
	case noDataAvailable
	case mappingError(Error)
	case unknownError(Error)
}

// MARK: - Localisation
extension NetworkError {

	public var errorDescription: String? {
		switch self {
		case .mappingError(let error), .unknownError(let error):
			return error.localizedDescription
		case .unexpectedStatus(let error):
			return "Response status code was unacceptable: \(error.code)."
		case .invalidRequest:
			return "Created request was invalid"
		case .noDataAvailable:
			return "Expected data is missing"
		}
	}
}
