//
//  NetworkEnvironment.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation

protocol NetworkEnvironment {
	var baseURL: URL { get }
	var defaultHeaders: [String: String]? { get }
}
