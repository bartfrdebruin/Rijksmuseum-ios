//
//  NetworkError.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

enum NetworkError: LocalizedError {
	case invalidRequest
	case noDataAvailable
	case mappingError(Error)
	case unknownError(Error)
}
