//
//  NetworkResponse.swift
//  Alamofire
//
//  Created by Wesley Hilhorst on 19/06/2020.
//

import Foundation

public struct NetworkResponse {

	public let request: URLRequest
	public let response: HTTPURLResponse
	public let data: Data?
}
