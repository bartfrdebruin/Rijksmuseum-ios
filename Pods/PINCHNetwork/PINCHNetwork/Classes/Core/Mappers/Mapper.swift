//
//  Mapper.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public protocol Mapper {

	associatedtype MappedType

	func processDataResponse(_ result: Result<NetworkResponse, NetworkError>) -> Result<MappedType, NetworkError>
	func processDataAsResult(_ data: Data) -> Result<MappedType, NetworkError>
	func processData(_ data: Data) throws -> MappedType
}
