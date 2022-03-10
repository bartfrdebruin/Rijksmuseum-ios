//
//  NetworkEnvironment.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public protocol NetworkEnvironment {

	var baseURL: URL { get }
	var defaultHeaders: [String: String]? { get }
}

// MARK: - Default values
public extension NetworkEnvironment {

	var defaultHeaders: [String: String]? {
		return nil
	}
}
